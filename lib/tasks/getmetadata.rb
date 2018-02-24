=begin
require "#{Rails.root}/app/models/getmetadata"

class Tasks::Getmetadata
  def self.execute
    Getmetadata.getmd
  end
end
=end

