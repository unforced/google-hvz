json.array!(@feeds) do |feed|
  json.extract! feed, :id, :tag_id, :player_id, :time
  json.url feed_url(feed, format: :json)
end
