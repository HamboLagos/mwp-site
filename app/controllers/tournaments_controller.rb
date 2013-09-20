class TournamentsController < ApplicationController
  include SessionsHelper

  def new
    unless admin?
      flash[:alert] = "You must have administrative privelages to create a new tournament"
      redirect_to root_path
    else
      @tournament = Tournament.new
      @current_season_athletes = Athlete.current_season_athletes
    end
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      flash[:notice] = "You have created a new tournament"
      redirect_to roster_path
    else
      @current_season_athletes = Athlete.current_season_athletes
      render 'new'
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  private

  def tournament_params
    params.require(:tournament).permit(:season_id, :location,
                                       :start_date, :end_date, athlete_ids: [])
  end

end
