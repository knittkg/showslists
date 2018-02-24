require "#{Rails.root}/app/jobs/get_audio_job"

class Tasks::GetAudioJob
  def self.perform
    GetAudioJob.perform_now
  end
end

