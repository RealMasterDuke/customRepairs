json.array!(@orders) do |order|
  json.extract! order, :id, :total
  json.url order_url(order, format: :json)
end
