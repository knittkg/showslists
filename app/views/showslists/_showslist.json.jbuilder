json.extract! showslist, :id, :live_date, :live_place, :live_pref, :last_modified, :filename, :name, :title, :length, :playtime, :created_at, :updated_at
json.url showslist_url(showslist, format: :json)
