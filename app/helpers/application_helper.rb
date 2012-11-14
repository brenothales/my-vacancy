module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def show_ordenation(field)
    content_tag(:span, :class => 'pull-right', :id => 'ordenations') do
      link_to("<i class='icon-arrow-up'></i>".html_safe, params.merge(:order_by => field, :ordem => 'ASC' )) +
      link_to("&nbsp;<i class='icon-arrow-down'></i>".html_safe, params.merge(:order_by => field, :ordem => 'DESC' ))
    end
  end

  #files in show pages
  def show_field_value(model_name, column_name, column_value)
    content_tag(:tr) do
      content_tag(:td, t("activerecord.attributes.#{model_name}.#{column_name}")) +
      content_tag(:td, column_value)
    end
  end
  
  def show_register_or_login
    content_tag(:ul, :class => 'nav pull-right') do 
      if user_signed_in?
        content_tag(:li, link_to("<strong>#{t('general.welcome')} : #{current_user.name}</strong>".html_safe, admin_root_path , :title => t('general.logged_user', :rel => 'tooltip', :data => { :placement => :bottom }) )) +
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
    Util.list_models.each { |modelo| html << render('admin/shared/menu_item', :model_for_menu => modelo.first.camelize) }
    html.html_safe
  end

  def show_active_desactive(objeto)
    #"/admin/#{controller_name}/#{objeto.id}/update_situation"
    if objeto.situation
      link_to("<i class='icon-remove'></i>".html_safe, 
              "/admin/#{controller_name}/#{objeto.id}",
              :method => :put, :rel => :tooltip, :title => t('cruds.table_list.tooltips.desactive'), 
              :data => { :placement => :top }, :remote => true) 
    else
      link_to("<i class='icon-ok'></i>".html_safe, 
              "/admin/#{controller_name}/#{objeto.id}", 
              :method => :put, :rel => :tooltip, :title => t('cruds.table_list.tooltips.active'), 
              :data => { :placement => :top }, :remote => true)
    end
  end

  def search_form_for_index(controller)
    route_for_search = { :controller => "admin/#{controller}", :action => :index }
    render :partial => "/admin/shared/form_search", :locals => { :route_for_search => route_for_search }
  end

  def quick_filters_by_read_or_unread(reads, unreads, action)
    render :partial => "/admin/shared/reads_unreads", :locals => { :reads => reads, :unreads => unreads, :controller_name => controller_name, :total => (reads.size + unreads.size), :action => action}
  end

  def quick_filters_by_category(for_sale, for_rent, for_buy)
    render :partial => "/admin/announcements/filter_by_category", :locals => { :for_sale => for_sale, :for_rent => for_rent, :for_buy => for_buy }
  end
  
  def to_real(value)
    number_to_currency(value, :unit => "R$ ", :separator => ".")  
  end

  def table_list(model_name, objetos, columns = [], custom_actions = [])
    merge_columns = th_columns = []    
    unless columns.empty?
      merge_columns = columns
      th_columns    = columns.map { |column| %[#{ t("activerecord.attributes.#{model_name}.#{column}")}  #{show_ordenation(column.to_sym)} ].html_safe  }
    end
    base_route = "/admin/#{model_name.to_s.underscore.downcase.pluralize}/"
    render :partial => "/admin/shared/table_list", :locals =>  { :objetos => objetos, :model_name => model_name, :base_route => base_route, :th_columns => th_columns, :merge_columns => merge_columns, :custom_actions => custom_actions }  
  end
  
  def list_new_comments(has_new_comments)
    html = %()
    unless has_new_comments.empty?
      has_new_comments.each do |comment|
        url = admin_comments_path
        html << content_tag(:div, :class => 'alert alert-info') do
          content_tag(:button,'x',:class => 'close', data: { dismiss: "alert"}) +
          "<i class='icon-eye-open'></i> #{t('dashboard.moderador.has_new_comments', :announcement => comment.announcement.name)}, #{link_to("<strong>Veja aqui</strong>".html_safe, url)}".html_safe
        end
      end
    end
    html.html_safe
  end

  def what_column(column, objeto)
    if column.eql?(:value)
      to_real(objeto.attributes[column.to_s])
    elsif column.eql?(:announcement_id)
      link_to objeto.announcement.name, admin_announcement_path(objeto.announcement), :rel => :tooltip, :title => t('cruds.table_list.tooltips.show'), :data => { :placement => :top }
    else 
      objeto.attributes[column.to_s] 
    end 
  end

  # não usados ainda
  def show_actions(objeto, show_all_menus = true, options = {})
    objeto_for_route = objeto.class.to_s.downcase.underscore.pluralize
    html = %()
    if show_all_menus
      html << link_to("<i class='icon-pencil'></i>".html_safe, "/admin/#{objeto_for_route}/#{objeto.id}/edit", :rel => 'tooltip', :title => t('cruds.table_list.tooltips.edit'), :data => { :placement => :top })
      html << link_to("<i class='icon-zoom-in'></i>".html_safe, "/admin/#{objeto_for_route}/#{objeto.id}", :rel => 'tooltip', :title => t('cruds.table_list.tooltips.show'), :data => { :placement => :top })
      html << link_to("<i class='icon-trash'></i>".html_safe, "/admin/#{objeto_for_route}#{objeto.id}", :method => :delete, :rel => 'tooltip', :title => t('cruds.table_list.tooltips.delete'), :confirm => t('cruds.table_list.tooltips.confirm'), :data => { :placement => :top })
    else
      actions = options[:actions] unless options[:actions].nil?
      if actions.kind_of? Array
        actions.each { |action| html << build_action_link(action, objeto) }
      else
        html << build_action_link(actions, objeto)
      end
    end
    html.html_safe
  end

  def build_action_link(action, objeto)
    objeto_for_route = objeto.class.to_s.downcase.underscore.pluralize
    case action
      when :show ; link_to("<i class='icon-zoom-in'></i>".html_safe, "/admin/#{objeto_for_route}/#{objeto.id}", :rel => 'tooltip', :title => t('cruds.table_list.tooltips.show'), :data => { :placement => :top })
      when :edit ; link_to("<i class='icon-pencil'></i>".html_safe, "/admin/#{objeto_for_route}/#{objeto.id}/edit", :rel => 'tooltip', :title => t('cruds.table_list.tooltips.edit'), :data => { :placement => :top })
      when :delete ; link_to("<i class='icon-trash'></i>".html_safe, "/admin/#{objeto_for_route}/#{objeto.id}", :method => :delete, :rel => 'tooltip', :title => t('cruds.table_list.tooltips.delete'), :confirm => t('cruds.table_list.tooltips.confirm'), :data => { :placement => :top })
      when :delete_ajax ; link_to("<i class='icon-trash'></i>".html_safe, "/admin/#{objeto_for_route}/#{objeto.id}", :method => :delete, :id => "#{objeto_for_route}_#{objeto.id}", :rel => 'tooltip', :title => t('cruds.table_list.tooltips.delete'), :confirm => t('cruds.table_list.tooltips.confirm'), :data => { :placement => :top }, :remote => true)      
      when :update_situation ; show_active_desactive(objeto)
    end
  end




end
