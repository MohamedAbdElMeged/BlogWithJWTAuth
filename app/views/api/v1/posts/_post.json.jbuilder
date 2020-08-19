json.id post.id
json.title post.title
json.body post.body
json.created_at post.created_at
json.updated_at post.updated_at
json.comments post.comments do |comment|
    json.id comment.id
    json.body comment.body
    json.created_at comment.created_at
    json.user do
        json.id comment.user.id
        json.first_name comment.user.first_name
        json.last_name comment.user.last_name
        json.email comment.user.email
        json.photo comment.user.photo
    end  
end
json.user do
    json.id post.user.id
    json.first_name post.user.first_name
    json.last_name post.user.last_name
    json.email post.user.email
    json.photo post.user.photo
end

