# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @question = Question.find_by(id: params[:id])

    if params[:id] && @question.nil?
      not_found
      return
    end

    if @question
      @serialized_question = {
        id: @question.id,
        question: @question.question,
        answer: @question.answer,
      }
    end

    @props = { 
      csrfToken: form_authenticity_token, 
      focusedQuestion: @serialized_question 
    }
  end
end
