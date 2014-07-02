json.array!(@missions) do |mission|
  json.extract! mission, :id, :time, :title, :description
  json.url mission_url(mission, format: :json)
end
