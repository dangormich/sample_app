# By using the symbol 'user', we get Factory Girl to simulate the User model
Factory.define :user do |user|
  user.name                  "Dan Gordon"
  user.email                 "dangormich@gmail.com"
  user.password              "123456"
  user.password_confirmation "123456"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end