module CancanHelper

  def user_can_handle_actions_for_model?(model, &block)
    permissions_type = [:manage, :read, :create, :update, :destroy]

    permissions_type.each do |permission|
      if can? permission, model.constantize
        yield   
        break 
      end
    end
		
  end

  #create a menu in nav-menu
  def nav_menu(nav_class = 'nav', &block)
    content_tag(:ul, :class => nav_class) do 
      block.call
    end
  end

  #create a menu item link like'Categories'
  def nav_menu_item(menu_label, &block)

    icon = case menu_label
    when 'announcement' ; "<i class='icon-book'></i>"
    end        

    menu_label = t("activerecord.models.#{menu_label}.other")
    content_tag(:li, :class => 'dropdown') do 
      link_to("#{icon} #{menu_label} <b class='caret'></b>".html_safe, '#', :class => 'dropdown-toggle', :data => { :toggle => 'dropdown' }) +
      content_tag(:ul, :class => 'dropdown-menu') do 
          capture(&block)#yield
      end
    end
  end

  #create a sub_menu link like 'List Categories'
  def nav_sub_menu_item(sub_menu_label, permission, route = '#', title = '', options = {})
    model_name = route.gsub( /(new|path|admin|_|\/)/, '').strip.capitalize.singularize.constantize
    controller = route.gsub(/(new|path|admin|_|\/)/, '').strip.downcase.underscore.pluralize
    text_new = t('cruds.new')
    text_list = t('cruds.list')    
    new_label = t("activerecord.models.#{sub_menu_label}.one")
    list_label = t("activerecord.models.#{sub_menu_label}.other")
    
    action, sub_menu_label, icon = permission.eql?(:create) ? [:new, "#{text_new} #{new_label}", "<i class='icon-plus'></i>"] : [:index, "#{text_list} #{list_label}", "<i class='icon-list-alt'></i>" ]
    new_route  = { :controller => "admin/#{controller}", :action => action }
    content_tag(:li, link_to("#{icon}  #{sub_menu_label}".html_safe, new_route, :title => title)) if can? permission, model_name
  end



end

