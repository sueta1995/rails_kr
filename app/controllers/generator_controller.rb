# frozen_string_literal: true

# controller for filling database
class GeneratorController < ApplicationController
  include GeneratorHelper

  def create
    @temp = []
    @status = true

    begin
      # clients_filling
      # banned_clients_filling
      # speech_therapist_filling
      # services_filling
      # rates_filling
      # comments_filling
      contracts_filling
    rescue StandardError => e
      @status = false
      @exception = e
    end
  end
end
