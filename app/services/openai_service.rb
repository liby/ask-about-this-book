class OpenaiService

  def initialize(question)
    @question = question
    @client = OpenAI::Client.new
  end

  def get_answer
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: @question }]
      }
    )
    response.dig("choices", 0, "message", "content")
  end

end
