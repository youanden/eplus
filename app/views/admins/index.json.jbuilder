json.array!(@admins) do |admin|
  json.extract! admin, :username, :created_at
  json.url admin_url(admin, format: :json)
end
