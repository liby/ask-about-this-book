require "ruby/openai"

if ENV.key?("OPENAI_API_KEY")
  OpenAI.configure do |config|
    config.access_token = ENV["OPENAI_API_KEY"]
  end
end