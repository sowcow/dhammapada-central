json.array!(@languages) do |language|
  json.extract! language, :index, :name
  json.url language_url(language, format: :json)
end
