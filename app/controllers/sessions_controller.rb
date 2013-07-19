class SessionsController < ApplicationController
  include FormErrorsHelper
  include SessionsHelper

  def new
    @form_errors = FormErrors.new
  end

  def create
    athlete = Athlete.find_by(email: sessions_params[:email])
    if athlete && athlete.authenticate(sessions_params[:password])
      sign_in athlete
      redirect_to roster_path
    else
      @form_errors = FormErrors.new("Invalid email/password combination")
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private

  def sessions_params
    params.permit(:email, :password)
  end
end
