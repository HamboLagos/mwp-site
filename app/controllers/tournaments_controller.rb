class TournamentsController < ApplicationController
  include SessionsHelper

  def new
    unless admin?
      flash[:alert] = "You must have administrative privelages to create a new tournament"
      redirect_to root_path
    else
      @tournament = Tournament.new
    end
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      flash[:notice] = "You have created a new tournament"
      redirect_to roster_path
    else
      render 'new'
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:season_id, :location, :start_date, :end_date)
    # , athlete_ids: [])
  end

end
