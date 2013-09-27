json.array!(@books) do |book|
  json.extract! book, :name
  json.url book_url(book, format: :json)
end
