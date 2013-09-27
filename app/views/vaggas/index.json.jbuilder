json.array!(@vaggas) do |vagga|
  json.extract! vagga, :index, :book_id
  json.url vagga_url(vagga, format: :json)
end
