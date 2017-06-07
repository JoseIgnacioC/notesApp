json.extract! note, :id, :title, :done, :created_at, :updated_at
json.url note_url(note, format: :json)
