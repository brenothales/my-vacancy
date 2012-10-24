#coding : utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(:name => 'administrador')
Role.create(:name => 'moderador')

User.create(:name => 'Luiz Cezer', :phone => '(45) 99858693', :email => 'lccezinha@gmail.com', :password => '123456', :role_id => Role.first.id, :situation => true)

Category.create(:name => 'Quarto', :situation => true)
Category.create(:name => 'Vaga em Republica', :situation => true)

State.create(:name => 'Paraná')
State.create(:name => 'São Paulo')

City.create(:name => "Medianeira", :state_id => 1)
City.create(:name => 'Foz do Iguaçu', :state_id => 1)
City.create(:name => 'São Paulo', :state_id => 2)
