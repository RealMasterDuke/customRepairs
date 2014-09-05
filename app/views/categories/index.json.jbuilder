json.array!(@categories) do |category|
  json.extract! category, :id, :title, :text, :image
  json.url category_url(category, format: :json)
end
