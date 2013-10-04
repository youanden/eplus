json.array!(@assignments) do |assignment|
  json.extract! assignment, :name, :value, :due_date, :classroom_id, :quizlet_id, :admin_id
  json.url assignment_url(assignment, format: :json)
end
