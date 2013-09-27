json.array!(@vaggas) do |vagga|
  json.extract! vagga, :name, :book_id
  json.url vagga_url(vagga, format: :json)
end
