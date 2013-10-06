json.array!(@students) do |student|
  json.extract! student, :username
  json.url student_url(student, format: :json)
end
