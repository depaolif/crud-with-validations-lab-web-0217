class Song < ActiveRecord::Base
  validates :title, {presence: true}
  validate :title_no_repeat
  validate :release_year_past_today
  validate :release_year_if_released
  validates :artist_name, presence: true

  def title_no_repeat
    same_song = Song.find_by(title: title)
    if !!same_song && same_song.title == title && same_song.release_year == release_year
      errors.add(:title, "Cannot have the same song released the same year")
    end
  end

  def release_year_past_today
    if release_year && release_year > Time.current.year
      errors.add(:release_year, "Must have been released before or during this year.")
    end
  end

  def release_year_if_released
    if released && !release_year.present?
      errors.add(:release_year, "Release year cannot be blank if it has released.")
    end
  end
end
