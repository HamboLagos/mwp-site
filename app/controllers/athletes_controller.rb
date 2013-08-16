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

  def edit
    @athlete = Athlete.find_by(id: params[:id])
  end

  def update
    @athlete = Athlete.find_by(id: params[:id])
    if @athlete.update(athlete_params)
      flash[:notice] = "The changes you made are pending the President's approval"
      redirect_to roster_path
    else
      render 'edit'
    end
  end

  def index
  end

  private

  def athlete_params
    params.require(:athlete).permit(:first_name, :last_name, :email,
                                    :year_in_school, :phone_number, :password,
                                    :password_confirmation)
  end
end
