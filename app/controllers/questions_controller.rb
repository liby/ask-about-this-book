class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    render json: @questions
  end

  def show
    @question = Question.find(params[:id])
    render json: @question
  end

  def create
    @question = Question.new(question_params)
    @question.answer = OpenAIService.fetch_answer(@question.question)
    if @question.save
      render json: @question, status: :created
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  def ask
    question = params[:question]
    service = OpenaiService.new(question)
    answer = service.get_answer
    render json: { answer: answer }
  end

  private

  def question_params
    params.require(:question).permit(:question, :answer, :context, :ask_count)
  end
end
