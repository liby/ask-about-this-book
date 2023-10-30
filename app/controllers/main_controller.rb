# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @props = { csrfToken: form_authenticity_token }
  end
end
