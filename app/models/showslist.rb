class Showslist < ApplicationRecord
  mount_uploader :filename, AudioUploader
end
