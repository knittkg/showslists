require 'open-uri'
require 'securerandom'
begin
  require "audioinfo"
rescue LoadError
  require "rubygems"
  require "audioinfo"
end

class GetAudioJob < ApplicationJob
  include ActionDispatch::TestProcess
  before_enqueue :set_artist, only: [:edit , :update]
  queue_as :default

  def perform(*args)
    @artists = Artist.all
    @artists.each do |artist|
      url = artist.url
      # puts url
      file = open(url)
      # puts file.last_modified
      last = artist.last_modified
      # puts last
      # Memo: lastとfile.last_modifiedの型を明示的に合わせる必要あり（以下の比較文が機能しなかった）

      if last.to_s == file.last_modified.to_s
        # puts "no need to DL"
      else 
        # puts "Start DL"
        filename = "#{Time.now.to_i}_#{SecureRandom.base64(8)}.mp3"
        # filenameの通り保存する。
        open(url) do |file|
          open(filename, "w+b") do |out|
            out.write(file.read)
          end
        end
        # puts 'new file stored'
        # Artist.last_modified の値を更新（次回チェック時の比較用）
        artist.last_modified=file.last_modified
        artist.save
        # puts 'last_modified record updated'

        # 保存したid3情報を読み出してファイル名とともにshowslistテーブルに新規登録する処理
          AudioInfo.open(filename) do |info|
            stat = File.stat(filename)
            Showslist.create( filename: fixture_file_upload(filename, 'audio/mpeg') , name: info.artist , title: info.title , length: stat.size , playtime: info.length)
            # puts 'recentshow.mp3 new entry created'
          end
        # 管理者宛に更新通知のメール送信
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:name, :url, :last_modified)
    end

end
