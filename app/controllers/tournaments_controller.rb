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
      flash[:notice] = "The next steps are optional, and can be completed later"
      redirect_to tournament_tournament_step_path(tournament_id: @tournament.id, id: 'athletes')
    else
      render 'new'
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update(tournament_params)
      redirect_to tournament_tournament_step_path(tournament_id: @tournament.id, id: 'athletes')
    else
      render 'edit'
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:season_id, :location, :start_date, :end_date)
  end

end

