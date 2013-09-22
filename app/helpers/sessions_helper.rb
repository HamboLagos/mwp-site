module SessionsHelper

  def current_athlete
    remember_token = Athlete.encrypt(cookies[:remember_token])
    @current_athlete ||= Athlete.find_by(remember_token: remember_token)
  end

  def current_athlete? other_athlete
    current_athlete == other_athlete
  end

  def current_athlete= athlete
    @current_athlete = athlete
  end

  def sign_in athlete
    remember_token = Athlete.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    athlete.update_attributes(remember_token: Athlete.encrypt(remember_token))
    self.current_athlete = athlete
  end

  def signed_in?
    !self.current_athlete.nil?
  end

  def sign_out
    self.current_athlete = nil
    cookies.delete(:remember_token)
  end

  def admin?
    if self.current_athlete
      self.current_athlete.admin?
    else
      false
    end
  end
end
