class Showslist < ApplicationRecord
  mount_uploader :filename, AudioUploader
  validates :live_date, length: { is: 8 }
end
