# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.destroy_all
# Idea.destroy_all

PASSWORD = 'pass123'



users = User.create([
  {username: 'Jon',  email: 'js@stark.gov', password_digest: PASSWORD},
  {username: 'Dany',  email: 'dt@dragonco.gov', password_digest: PASSWORD},
  {username: 'Benjen',  email: 'bs@stark.gov', password_digest: PASSWORD},
  {username: 'bren',  email: 'bren@bren.ca', password_digest: PASSWORD}
])

10.times do
  Idea.create title: Faker::App.name,
                  body:  Faker::StarWars.quote
end
1.times do
  User.create username: 'bren',
                  email:  'bren@bren.ca',
                  password_digest: PASSWORD
end



puts Cowsay.say 'created 10 Ideas', :cow
