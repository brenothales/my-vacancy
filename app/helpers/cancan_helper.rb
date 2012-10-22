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
      capture(&block) #yield
    end
  end

  #create a menu item link like'Categories'
  def nav_menu_item(menu_label, &block)
    
    icon = case menu_label
    when 'category' ; "<i class='icon-tag'></i>"
    when 'user' ; "<i class='icon-user'></i>"
    when 'post' ; "<i class='icon-font'></i>"
    when 'comment' ; "<i class='icon-comment'></i>"
    when 'archive' ; "<i class='icon-upload'></i>"
    end        

    menu_label = t("activerecord.models.#{menu_label}")
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
    sub_menu_label = t("activerecord.models.#{sub_menu_label}")
    action, sub_menu_label = permission.eql?(:create) ? [:new, "Cadastrar #{sub_menu_label}"] : [:index, "Listar #{sub_menu_label}"]
    new_route  = { :controller => "admin/#{controller}", :action => action }
    content_tag(:li, link_to(sub_menu_label, new_route, :title => title)) if can? permission, model_name
  end



end

