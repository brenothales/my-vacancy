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

User.create(:name => 'Luiz Cezer', :email => 'lccezinha@gmail.com', :password => '123456', :role_id => Role.first.id, :situation => true, :phone => '(45) 9985-8693')
User.create(:name => 'Cezer Filho', :email => 'lc_cezinha@hotmail.com', :password => '123456', :role_id => 2, :situation => true, :phone => '(45) 9988-7788')

Category.create(:name => 'Aluguel', :situation => true)
Category.create(:name => 'Compra', :situation => true)
Category.create(:name => 'Venda', :situation => true)
Category.create(:name => 'Troca', :situation => true)

State.create(:name => 'Paraná', :uf => "PR")
State.create(:name => 'São Paulo', :uf => "SP")

City.create(:name => "Medianeira", :state_id => 1)
City.create(:name => 'Foz do Iguaçu', :state_id => 1)
City.create(:name => 'São Paulo', :state_id => 2)

Announcement.create(:name => 'Anuncio muito bom', :value => '800,00', :category_id => 1, :city_id => 1, :content => 'descricao sobre o anucio', :user_id => 2)
Announcement.create(:name => 'Anuncio ruim pra caralho', :value => '100,00', :category_id => 3, :city_id => 2, :content => 'descricao sobre o anucio', :user_id => 2)

Comment.create(:name => 'Rafel Tibola', :email => 'tibola@gmail.com', :content => 'ese e o meu comentario', :announcement_id => 1)
