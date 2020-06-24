# This will guess the User class
FactoryBot.define do
  factory :user do
    first_name { 'George' }
    last_name  { 'Abitbol' }
    email { 'abitbol_george@gmail.com' }
    password { 'monde_de_merde' }
  end
end
