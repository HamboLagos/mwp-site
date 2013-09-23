class AthletesController < ApplicationController
  include FormErrorsHelper
  include SessionsHelper
  include AuthorizationHelper

  before_action :signed_in_user, only: [:edit, :update, :change_password, :commit_password_change]
  before_action :correct_user, only: [:edit, :update, :change_password, :commit_password_change]

  def new
    @athlete = Athlete.new
  end

  def create
    @athlete = Athlete.new(new_athlete_params)
    if @athlete.save
      flash[:notice] = "Welcome #{@athlete.name}. Your acceptance to the Team Roster is pending " +
        "the President's approval"
      redirect_to roster_path
    else
      render 'new'
    end
  end

  def edit
    if admin? && Athlete.find_by(id: params[:id]) != current_athlete
      flash.now[:notice] = "You are editing another player's profile"
    end
    @athlete = Athlete.find_by(id: params[:id])
  end

  def update
    @athlete = Athlete.find_by(id: params[:id])

    if @athlete.update(edit_athlete_params)
      flash[:notice] = "The changes you made are pending the President's approval"
      redirect_to roster_path
    else
      render 'edit'
    end
  end

  def index
    @current_season_athletes = Athlete.current_season_athletes
  end

  # end of standard RESTful athlete routes

  def change_password
    unless current_athlete == Athlete.find(params[:id]) #admins can't change another athlete's pw
      flash['error'] = "You are not authorized to perform this action"
      redirect_to edit_athlete_path(Athlete.find(params[:id]))
    else
      @form_errors = FormErrors.new
    end
  end

  def commit_password_change
    unless current_athlete == Athlete.find(params[:id]) #admins can't change another athlete's pw
      flash['error'] = "You are not authorized to perform this action"
      redirect_to edit_athlete_path(Athlete.find(params[:id]))
    else
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
  end

  private

  def new_athlete_params
    params.require(:athlete).permit(:first_name, :last_name, :email,
                                    :year_in_school, :phone_number, :password,
                                    :password_confirmation, season_ids: [])
  end

  def edit_athlete_params
    params.require(:athlete).permit(:first_name, :last_name, :email,
                                    :year_in_school, :phone_number, season_ids: [])
  end

  def season_params
    params.require(:athlete).permit(:seasons)
  end

  def change_password_params
    params.permit(:password, :password_confirmation)
  end
end
