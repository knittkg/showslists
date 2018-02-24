require 'open-uri'
require 'securerandom'

class GetAudioJob < ApplicationJob
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
      # Memo: lastとfile.last_modifiedの型を明示的に合わせる必要があるかも
      if last == file.last_modified
        puts "no need to DL"
      else 
        puts "Start DL"
        filename = "#{Time.now.to_i}_#{SecureRandom.base64(8)}.mp3"
        puts filename
        # filenameの通り保存する。本当は保存時のディレクトリを指定すべきだがこれから調査
        open(url) do |file|
            puts filename
            puts url
          open(filename, "w+b") do |out|
            out.write(file.read)
          end
        end
        # Artist.last_modified の値を更新
        #puts file.last_modified        
        #binding.pry
        #@artist.update(last_modified: file.last_modified )
        #puts @artist.last_modified
        #@artist.update(:last_modified)
        artist.last_modified=file.last_modified
        artist.save

        # 保存したid3情報を読み出してファイル名とともにshowslistテーブルに新規登録する処理
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
