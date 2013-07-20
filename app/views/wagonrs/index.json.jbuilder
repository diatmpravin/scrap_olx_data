json.array!(@wagonrs) do |wagonr|
  json.extract! wagonr, :olx_id, :posted_date, :model, :Mileage, :price, :name, :base_link
  json.url wagonr_url(wagonr, format: :json)
end
