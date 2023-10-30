require 'json'
require 'cosine_similarity'
require 'tokenizers'
require 'ruby/openai'

class OpenaiService

  def initialize
    @tokenizer = Tokenizers.from_pretrained("gpt2")
    @openai_client = OpenAI::Client.new
  end

  def get_answer(question)
    question_embedded = get_question_embedding(question)
    similar_content = get_similar_content(question_embedded)
    chosen_sections = select_relevant_sections(similar_content)

    construct_response_for_openai(question, chosen_sections)
  rescue StandardError => e
    { error: e.message }
  end

  private

  def get_question_embedding(question)
    response = @openai_client.embeddings(
      parameters: {
        model: "text-embedding-ada-002",
        input: question
      }
    )
    response["data"][0]["embedding"]
  end

  def get_similar_content(question_embedding)
    content_data = JSON.parse(File.read("db/data/book.pdf.embeddings.json"))
    content_data.map do |entry|
      {
        content: entry["Content"],
        similarity: cosine_similarity(question_embedding, entry["Embedding"]),
        token_count: entry["Tokens"]
      }
    end.sort_by { |item| -item[:similarity] }
  end

  def select_relevant_sections(similarity_data)
    accumulated_tokens = 0
    selected_sections = []

    similarity_data.each do |data|
      content = data[:content]
      encoded_content = @tokenizer.encode(content).ids
      content_token_count = data[:token_count]

      if accumulated_tokens + content_token_count > MAX_SECTION_LEN
        remaining_space = MAX_SECTION_LEN - accumulated_tokens
        sliced_content = @tokenizer.decode(encoded_content.take(remaining_space))
        selected_sections << sliced_content
        break
      end

      accumulated_tokens += content_token_count
      selected_sections << content
    end

    selected_sections
  end

  def construct_response_for_openai(question, sections)
    combined_sections = HEADER + sections.join(SEPARATOR) + generate_q_and_a_string
    prompt = combined_sections + "\n\n\nQ: #{question}\n\nA: "

    response = @openai_client.completions(
      parameters: ::COMPLETIONS_API_PARAMS.merge({ prompt: prompt })
    )
    { answer: response["choices"][0]["text"], context: combined_sections }
  end

  def generate_q_and_a_string
    QUESTIONS.map do |q|
      "\n\n\nQ: #{q[:question]}\n\nA: #{q[:answer]}"
    end.join
  end
end
