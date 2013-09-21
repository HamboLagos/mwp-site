class TournamentStepsController < ApplicationController
  include SessionsHelper
  include Wicked::Wizard

  steps :athletes, :drivers, :passengers

  def show
    @tournament = Tournament.find(params[:tournament_id])

    case step
    when :athletes
      @current_season_athletes = Athlete.current_season_athletes.sort! do
        |a, b| a.last_name <=> b.last_name
      end
    when :drivers
      @travel_rosters = @tournament.travel_rosters
    when :passengers
      @travel_rosters = @tournament.travel_rosters

      @drivers = []
      @travel_rosters.find_all { |tr| tr.driver? }.each do |tr|
        @drivers << tr.athlete
      end
    end
    render_wizard
  end

  def update
    @tournament = Tournament.find(params[:tournament_id])
    case step
    when :athletes
      @tournament.update(athlete_params)
    when :drivers
      @tournament.update(driver_params)
    when :passengers
      @tournament.update(passenger_params)
    end
    render_wizard @tournament
    # render wizard_path(:passengers)
  end

  def finish_wizard_path
    tournaments_path
  end

  private

  def athlete_params
    params.require(:tournament).permit(athlete_ids: [])
  end

  def driver_params
    params.require(:tournament).permit(travel_rosters_attributes: [:id, :driver])
  end

  def passenger_params
    params.require(:tournament).permit(travel_rosters_attributes: [:id, :car])
  end

end
