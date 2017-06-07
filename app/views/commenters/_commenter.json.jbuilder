json.extract! commenter, :id, :message, :created_at, :updated_at
json.url commenter_url(commenter, format: :json)
