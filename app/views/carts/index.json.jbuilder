json.array!(@carts) do |cart|
  json.extract! cart, :id, :purchased_at
  json.url cart_url(cart, format: :json)
end
