module AuthorizationHelper

  #reopens Athlete model
  Athlete.class_eval do

    def authorized?(request_id)
      self == Athlete.find_by(id: request_id) || self.admin?
    end
  end
end
