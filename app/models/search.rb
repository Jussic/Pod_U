class Search < ActiveRecord::Base
  def self.for(keyword)
    Podcast.where('LOWER(title) LIKE ?', "%#{keyword.downcase}%") +
    Podcast.where('LOWER(description) LIKE ?', "%#{keyword.downcase}%")
  end
end
