
class SessionsController < ApplicationController
  include FormErrorsHelper

  def new
    @form_errors = FormErrors.new
  end

  def create
    athlete = Athlete.find_by(email: sessions_params[:email].downcase)
    if athlete && athlete.authenticate(sessions_params[:password])
      # sign_in athlete
      redirect_to root_path
    else
      @form_errors = FormErrors.new("Invalid email/password combination")
      render 'new'
    end
  end

  def destroy
  end

  private

  def sessions_params
    params.permit(:email, :password)
  end

  class InFormErrors
    attr_accessor :errors

    def initialize(*errors)
      @errors = ErrorFields.new(errors)
    end

  end

  class ErrorFields < Array

    def full_messages
      self
    end
  end

end
