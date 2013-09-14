class AthletesController < ApplicationController
  include FormErrorsHelper

  def new
    @athlete = Athlete.new
  end

  def create
    @athlete = Athlete.new(athlete_params)
    if @athlete.save
      flash[:notice] = "Welcome #{@athlete.name}. Your acceptance to the Team Roster is pending " +
        "the President's approval"
      redirect_to roster_path
    else
      render 'new'
    end
  end

  def edit
    @athlete = Athlete.find_by(id: params[:id])
  end

  def update
    @athlete = Athlete.find_by(id: params[:id])

    if !@athlete.authenticate(params[:athlete][:password])
      @athlete.errors.add(:password, 'entered does not match our records')
      @athlete.errors.add(:password, 'must be entered to confirm changes')
      render 'edit'
    elsif @athlete.update(athlete_params)
      flash[:notice] = "The changes you made are pending the President's approval"
      redirect_to roster_path
    else
      render 'edit'
    end
  end

  def index
  end

  # end of standard RESTful athlete routes

  def change_password
    @form_errors = FormErrors.new
  end

  def commit_password_change
    @athlete = Athlete.find_by(id: params[:id])

    @form_errors = FormErrors.new
    if params[:old_password] != params[:old_password_confirmation]
      @form_errors << 'Old Password and Old Password Confirmation do not match'
    end
    if params[:new_password] != params[:new_password_confirmation]
      @form_errors << 'New Password and New Password Confirmation do not match'
    end

    if @form_errors.errors == [] && @athlete.authenticate(params[:old_password])
      if @athlete.update(change_password_params) && !params[:password].blank?
        flash[:notice] = "You have successfully changed your password"
        redirect_to edit_athlete_path(@athlete)
      else
        @athlete.errors.full_messages.each do |message|
          @form_errors << message
        end
        if params[:password].blank?
          @form_errors << 'Password cannot be blank'
        end
        render 'change_password'
      end
    else
      @form_errors << 'Old Password field is incorrect'
      render 'change_password'
    end
  end

  private

  def athlete_params
    params.require(:athlete).permit(:first_name, :last_name, :email,
                                    :year_in_school, :phone_number, :password,
                                    :password_confirmation)
  end

  def change_password_params
    params.permit(:password, :password_confirmation)
  end
end
