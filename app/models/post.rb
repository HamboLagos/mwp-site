class Post < ActiveRecord::Base
  belongs_to :athlete

  validates :title, presence: true
  validates :content, presence: true
  validates :athlete, presence: true

  def author
    self.athlete
  end

  def author= other
    self.athlete = other
  end

  def author? other
    author == other?
  end
end
