json.extract! artist, :id, :name, :url, :last_modified, :created_at, :updated_at
json.url artist_url(artist, format: :json)
