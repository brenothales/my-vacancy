module ApplicationHelper
  
  
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

  def show_active_desactive(announcement)
    announcement.situation ? link_to("<i class='icon-remove'></i>".html_safe, '#', :rel => 'tooltip', :title => t('cruds.table_list.tooltips.desactive'), :data => { :placement => :top }) : link_to("<i class='icon-ok'></i>".html_safe, '#', :rel => 'tooltip', :title => t('cruds.table_list.tooltips.active'), :data => { :placement => :top })
  end

  def search_form_for_index(controller)
    route_for_search = { :controller => "admin/#{controller}", :action => :index }
    render :partial => "/admin/shared/form_search", :locals => { :route_for_search => route_for_search }
  end



end
