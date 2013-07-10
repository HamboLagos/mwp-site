class AthletesController < ApplicationController

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

  def update
    Athlete.find(params[:id]).update!(athlete_params)
  end

  def index
  end

  private

  def athlete_params
    params.require(:athlete).permit(:first_name, :last_name, :email,
                                    :password, :password_confirmation)
  end
end
