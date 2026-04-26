json.extract! todo, :id, :content, :status, :created_by, :created_at, :updated_at
json.url todo_url(todo, format: :json)
