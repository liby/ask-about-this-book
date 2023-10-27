require "openai"

OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_API_KEY")
  config.uri_base = ENV.fetch("OPENAI_API_URL") # Optional.
end