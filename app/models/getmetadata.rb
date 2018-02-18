require 'open-uri'
url = 'http://www.geocities.co.jp/Broadway-Guitar/1124/recentshow.mp3'
# url = @artist.url 本来の発送は、artistテーブルに登録されたurlを読みだして代入し以下のopenコマンドを実行
file = open(url)
# puts file.last_modified >> ../../log/metadata_timestamp.log
# puts file.length
File.open("../../log/metadata_timestamp.log", "a") do |f|
  f.puts(file.last_modified)
end
