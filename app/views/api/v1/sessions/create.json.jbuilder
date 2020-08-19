json.user do
    json.id user.id
    json.email user.email
    json.first_name user.first_name
    json.last_name user.last_name
    json.photo user.photo

end
json.access_token access_token
json.refresh_token refresh_token
