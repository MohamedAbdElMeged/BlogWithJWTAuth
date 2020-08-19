if @user !=nil
    json.id @user.id
    json.first_name @user.first_name
    json.last_name @user.last_name
    json.email @user.email
    json.photo @user.photo
    json.created_at @user.created_at

else
    json.user nil
end
