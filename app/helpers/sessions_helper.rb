module SessionsHelper

  def current_athlete
    @current_athlete ||= Athlete.find_by(remember_token: cookies[:remember_token])
  end

  def current_athlete? other_athlete
    current_athlete == other_athlete
  end

  def current_athlete= athlete
    @current_athlete = athlete
  end

  def sign_in athlete
    cookies[:remember_token] = athlete.remember_token
    self.current_athlete = athlete
  end
end
