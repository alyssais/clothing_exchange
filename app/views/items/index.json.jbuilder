json.array!(@items) do |item|
  json.extract! item, :id, :title, :description, :email
  json.url item_url(item, format: :json)
end
