require 'open-uri'

class Getmetadata < ActiveRecord::Base
  def self.getmd()
    # Artstテーブルの情報を読み出す 
    @artists = Artist.all
    # 最終更新情報を読み出す
    @artists.each do |artist|
    url = artist.url
    # puts url
    # サイト側の最終更新情報読み出し
    file = open(url)
    puts file.last_modified
    # 自分の保存している最終更新情報を読み出し
    last = artist.last_modified
    puts last
    # 突合して一致していたら処理終了、不一致だったらダウンロード
    if last == file.last_modified
      # puts "no need to DL"
    else 
      # puts "Start DL"
      # 保存時のファイル名を設定 UNIX時間でユニーク性を担保
      filename = "#{Time.now.to_i}.mp3"
      # filenameの通り保存する。本当は保存時のディレクトリを指定すべきだがこれから調査
      open(url) do |file|
        open(filename, "w+b") do |out|
        out.write(file.read)
        end
      end
      # 未実装処理は下記の通り
      # Artist.last_modified の値を更新
      # 保存したid3情報を読み出してファイル名とともにshowslistテーブルに新規登録する処理
      # 管理者宛に更新通知のメール送信

    end
    end
  end
end

