class Ticket < ActiveRecord::Base
  belongs_to :user

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    song = self.all.find do |s|
      s.slug == slug
    end
  end

end
