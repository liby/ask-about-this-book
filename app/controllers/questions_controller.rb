require "tokenizers"
require "ruby/openai"

class QuestionsController < ApplicationController
  before_action :initialize_services, only: [:ask]
  before_action :find_existing_question, only: [:ask]

  def ask
    cached_answer = retrieve_answer_from_cache

    if cached_answer
      render json: cached_answer
    else
      answer_from_openai = @openai_service.get_answer(@question)

      if answer_from_openai[:error]
        render_error_response(answer_from_openai[:error])
      else
        new_question = Question.create(
          question: @question,
          answer: answer_from_openai[:answer],
          context: answer_from_openai[:context],
          ask_count: 1
        )

        render json: {
          id: new_question.id,
          source: "openai",
          question: @question,
          answer: answer_from_openai[:answer]
        }
      end
    end
  rescue => e
    render_error_response(e.message, details: e.backtrace[0..5], status_code: 500)
  end

  private

  def initialize_services
    @openai_service = OpenaiService.new
  end

  def find_existing_question
    @question = params[:question]
    @previous_question = Question.find_by(question: @question)
  end

  def retrieve_answer_from_cache
    if @previous_question
      @previous_question.increment!(:ask_count)
      {
        id: @previous_question.id,
        source: "database",
        question: @question,
        answer: @previous_question.answer
      }
    else
      nil
    end
  end

  def render_error_response(message, details: nil, status_code: 400)
    error_response = {
      error: {
        message: message,
        type: 'ServerError',
        status_code: status_code
      }
    }

    error_response[:error][:details] = details if details

    render json: error_response, status: status_code
  end
end
