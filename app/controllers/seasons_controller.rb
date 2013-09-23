class SeasonsController < ApplicationController
  include SessionsHelper

  before_action :administrative_user

  def new
    unless admin?
      flash[:alert] = "You must have administrative privelages to create a new season"
      redirect_to root_path
    else
      @season = Season.new
    end
  end

  def create
    @season = Season.new(season_params)
    if @season.save
      flash[:notice] = "You have created a new season"
      redirect_to roster_path
    else
      render 'new'
    end
  end

  private

  def season_params
    params.require(:season).permit(:year)
  end

end
