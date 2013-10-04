json.array!(@classrooms) do |classroom|
  json.extract! classroom, :name, :quizlet_id, :admin_id
  json.url classroom_url(classroom, format: :json)
end
