class Artist < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
end
