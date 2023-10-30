require 'pdf-reader'
require 'json'
require 'tokenizers'
require 'ruby/openai'
require 'dotenv'

Dotenv.load(File.join(File.dirname(__FILE__), '../.env'))

OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_API_KEY")
end

class PDFEmbeddingsProcessor
  attr_reader :pdf_path

  def initialize(pdf_path)
    @pdf_path = pdf_path
    @tokenized = Tokenizers.from_pretrained('gpt2')
    @openai_client = OpenAI::Client.new
  end

  def extract_text_from_page(page)
    page.text.gsub("\n", '').strip
  end

  def tokenize_text(text)
    @tokenized.encode(text).tokens.size
  end

  def get_embedding(pdf_text)
    max_retries = 3
    retries = 0

    begin
        response = @openai_client.embeddings(
            parameters: {
                model: "text-embedding-ada-002",
                input: pdf_text
            }
        )
        embedding = extract_embedding_from_response(response)
    rescue StandardError => e
        retries += 1
        if retries < max_retries
            puts "Encountered an error: #{e}. Retrying (#{retries}/#{max_retries})..."
            sleep(10 * retries)
            retry
        else
            puts "Failed to obtain embedding after #{max_retries} attempts."
            return nil
        end
    end
    embedding
  end

  def extract_embedding_from_response(response)
      response.dig('data', 0, 'embedding') || []
  end

  def process
    data = []
    PDF::Reader.open(pdf_path) do |pdf|
      pdf.pages.each_with_index do |page, idx|
        content = extract_text_from_page(page)
        tokens = tokenize_text(content)
        embedding = get_embedding(content)
        data << {
          'Page' => idx + 1,
          'Content' => content,
          'Tokens' => tokens,
          'Embedding' => embedding
        }
      end
    end
    data
  end
end

if ARGV.length != 1
  puts "Usage: ruby script_name.rb <path_to_pdf>"
  exit
end

processor = PDFEmbeddingsProcessor.new(ARGV[0])
result_data = processor.process

File.write('book.pdf.embeddings.json', JSON.pretty_generate(result_data))
puts "Processing complete. Data saved to pbook.pdf.embeddings.json."
