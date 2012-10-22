# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(:name => 'administrador')
Role.create(:name => 'moderador')

User.create(:full_name => 'Luiz Cezer', :phone => '(45) 99858693', :city_id => 1, :email => 'lccezinha@gmail.com', :password => '123456', :role_id => Role.first.id, :situation => true)

Category.create(:name => 'Quarto', :situation => true)
Category.create(:name => 'Vaga em Republica', :situation => true)
