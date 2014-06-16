json.array!(@orders) do |order|
  json.extract! order, :id, :order_number, :ordered_at, :on_hold
  json.url order_url(order, format: :json)
end
