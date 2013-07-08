class AthletesController < ApplicationController

  def new
    @athlete = Athlete.new
  end

  def create
    @athlete = Athlete.new(athlete_params)
    render 'new' unless @athlete.save
  end

  def update
    Athlete.find(params[:id]).update!(athlete_params)
  end

  private

  def athlete_params
    params.require(:athlete).permit(:first, :last, :email,
                                    :password, :password_confirmation)
  end
end
