require 'yaml'

module Util

	def self.list_models
    #Dir.foreach("#{Rails.root}/app/models") do |arquivo|
    #  models << arquivo.gsub('.rb', '').camelcase unless arquivo =~ /^\.|role|util|ability|state|city|category|comment/
    #end
    menus = YAML::load(File.open('config/models_for_menu.yml')).sort_by { |menu| menu.second['order'] }
    #menus = menus.sort_by { |menu| menu.second['order'] }
    #puts menus[:menus]
    #models
	end

  def self.clean_development_log
    File.delete('log/development.log')
    File.open('log/development.log', 'a')  
  end
	
end
