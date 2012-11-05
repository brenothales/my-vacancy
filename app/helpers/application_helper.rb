module ApplicationHelper

  def show_ordenation(field)
    content_tag(:span, :class => 'pull-right', :id => 'ordenations') do
      link_to("<i class='icon-arrow-up'></i>".html_safe, params.merge(:order_by => field, :ordem => 'ASC' )) +
      link_to("&nbsp;<i class='icon-arrow-down'></i>".html_safe, params.merge(:order_by => field, :ordem => 'DESC' ))
    end
  end
  
  def show_register_or_login
    content_tag(:ul, :class => 'nav pull-right') do 
      if user_signed_in?
        content_tag(:li, link_to("<strong>#{t('general.welcome')} : #{current_user.name}</strong>".html_safe, 'javascript:void(0)' , :title => t('general.logged_user', :rel => 'tooltip', :data => { :placement => :bottom }) )) +
        content_tag(:li, '' ,:class => 'divider-vertical') +
        content_tag(:li, link_to("Logout  <i class='icon-off'></i>".html_safe, destroy_user_session_path, :method => :delete, :confirm => t('devise_forms.logout_confirm')))
      else
        content_tag(:li, link_to("<b>#{t('general.register')}</b>  <b class='icon-arrow-up'></b>".html_safe, new_user_registration_path, :title => t('tooltips.register'), :rel => 'tooltip', :data => { :placement => :bottom })) +
        content_tag(:li, '', :class => 'divider-vertical') +
        content_tag(:li, link_to("<b>#{t('general.login')}</b>  <b class='icon-user'></b>".html_safe, new_user_session_path, :title => t('tooltips.login'), :rel => 'tooltip', :data => { :placement => :bottom }) )
      end    
    end
  end

  def dashboard_for_role(role)
    role.eql?('administrador') ? render('/admin/shared/dashboard_administrador') : render('/admin/shared/dashboard_moderador') 
  end

  def create_menus
    html = %()
    Util.list_models.each { |model| html << render('admin/shared/menu_item', :model_for_menu => model) }
    html.html_safe
  end

  def show_active_desactive(objeto)
    objeto.situation ? link_to("<i class='icon-remove'></i>".html_safe, '#', :rel => 'tooltip', :title => t('cruds.table_list.tooltips.desactive'), :data => { :placement => :top }) : link_to("<i class='icon-ok'></i>".html_safe, '#', :rel => 'tooltip', :title => t('cruds.table_list.tooltips.active'), :data => { :placement => :top }) if objeto.respond_to? :situation
  end

  def search_form_for_index(controller)
    route_for_search = { :controller => "admin/#{controller}", :action => :index }
    render :partial => "/admin/shared/form_search", :locals => { :route_for_search => route_for_search }
  end

  def quick_filters_by_category(for_sale, for_rent, for_buy)
    render :partial => "/admin/shared/filter_by_category", :locals => { :for_sale => for_sale, :for_rent => for_rent, :for_buy => for_buy }
  end

  def table_list(model_name, objetos)
    #TURN IT MORE DYNAMIC
    model_name = model_name.to_s
    base_route = "/admin/#{model_name.to_s.underscore.downcase.pluralize}/"
    render :partial => "/admin/shared/table_list", :locals =>  { :objetos => objetos, :model_name => model_name, :base_route => base_route }  
  end
  



  # não usados ainda
  def show_actions(objeto, show_all_menus = true, options = {})
    objeto_for_route = objeto.class.to_s.downcase.underscore.pluralize
    html = %()
    if show_all_menus
      html << link_to("<i class=\"icon-list-alt\"></i> Detalhes".html_safe,"/admin/#{objeto_for_route}/#{objeto.id}",:class => 'btn')
      html << link_to("<i class=\"icon-refresh\"></i> Editar".html_safe, "/admin/#{objeto_for_route}/#{objeto.id}/edit",:class => 'btn')
      html << link_to("<i class=\"icon-trash\"></i> Excluir".html_safe, "/admin/#{objeto_for_route}/#{objeto.id}", method: :delete, data: { confirm: 'Deseja Realmente excluir ?' },:class => 'btn')
    else
      actions = options[:actions] unless options[:actions].nil?
      if actions.kind_of? Array
        actions.each { |action| html << build_action_link(action, objeto) }
      else
        html << build_action_link(actions, objeto)
      end
    end
    content_tag(:td, html.html_safe, :class => 'actions btn-group')
  end

  def build_action_link(action, objeto)
    case action
      when 'show' ; link_to("<i class=\"icon-list-alt\"></i> Detalhes".html_safe,"/admin/#{objeto.class.to_s.downcase.underscore.pluralize}/#{objeto.id}",:class => 'btn')
      when 'edit' ; link_to("<i class=\"icon-refresh\"></i> Editar".html_safe, "/admin/#{objeto.class.to_s.downcase.underscore.pluralize}/#{objeto.id}/edit",:class => 'btn')
      when 'delete' ; link_to("<i class=\"icon-trash\"></i> Excluir".html_safe, "/admin/#{objeto.class.to_s.downcase.underscore.pluralize}/#{objeto.id}", method: :delete, data: { confirm: 'Deseja Realmente excluir ?' },:class => 'btn')
    end
  end




end
