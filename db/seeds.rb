Role.create!(:name => "Admin")
Role.create!(:name => "User")

user = User.create!(
  :email => "admin@yoursite.com",
  :password => "password",
  :password_confirmation => "password")
user.confirm!
user.role_ids = [ 1, 2 ]
user.save!
