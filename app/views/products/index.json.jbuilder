json.array!(@products) do |product|
  json.extract! product, :id, :title, :text, :category_id, :image, :price
  json.url product_url(product, format: :json)
end
