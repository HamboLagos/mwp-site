class Athlete < ActiveRecord::Base
  has_secure_password

  has_many :posts
  has_many :team_rosters
  has_many :seasons, through: :team_rosters

  before_validation { self.email.downcase! }
  before_create :create_remember_token

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :year_in_school, presence: true
  validates :phone_number, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  # other is space deflimited string containing first and last names
  # yes: "Samuel Jackson", "Omar Rodriguez-Lopez"
  # no: "Booker T. Washington" => "Booker Washington"
  def name= other
    self.first_name = other.split.first
    self.last_name = other.split.last
  end

  def name? other
    name == other
  end

  def == other
    return true if other.equal?(self)
    return false unless other.kind_of?(self.class)
    first_name == other.first_name &&
      last_name == other.last_name &&
      email == other.email &&                   # with unique emails, this is important check
      year_in_school == other.year_in_school
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = Athlete.encrypt(Athlete.new_remember_token)
  end
end
