json.array!(@gathas) do |gatha|
  json.extract! gatha, :name, :vagga_id
  json.url gatha_url(gatha, format: :json)
end
