json.array!(@books) do |book|
  json.extract! book, :index
  json.url book_url(book, format: :json)
end
