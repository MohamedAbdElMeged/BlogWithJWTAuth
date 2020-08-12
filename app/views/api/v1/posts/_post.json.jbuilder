json.id post.id
json.title post.title
json.body post.body
json.created_at post.created_at
json.updated_at post.updated_at
json.comments post.comments
json.user do
    json.id post.user.id
    json.first_name post.user.first_name
    json.last_name post.user.last_name
    json.email post.user.email
    json.photo post.user.photo
end

