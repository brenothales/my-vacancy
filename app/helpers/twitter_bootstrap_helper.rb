#coding : utf-8
module TwitterBootstrapHelper
  
  #show flash message on top with de message dãr
  def show_flash(flash)   
    unless flash.nil? || flash.empty?
      clazz = case flash.first.first
        when :notice  ; 'alert alert-success'
        when :alert   ; 'alert alert-error'
        when :warning ; 'alert alert-warning'
      end
      content_tag(:div, :class => clazz) do 
        content_tag(:button,'x',:class => 'close', data: { dismiss: "alert"}) + 
        content_tag(:h3, flash.first.second)
      end
    end     
  end

  def alert_list_empty
    content_tag(:div,:class => 'alert') do
      content_tag(:button,'x',:class => 'close', data: { dismiss: "alert"})
      content_tag(:h3, t('general.empty_list'))
    end
  end  

  def itens_per_page
    content_tag(:div, :class => 'btn-group', :style => 'display:inline-block;') do
      
      link_to("#{t('forms.per_page.list')} <span class='caret'></span>".html_safe, 'javascript:void(0)', :class => 'btn dropdown-toggle',:data => {:toggle => 'dropdown'}) +
      content_tag(:ul, :class => 'dropdown-menu') do
        content_tag(:li, link_to('3', params.merge(:per_page => 3))) +
        content_tag(:li, link_to('5', params.merge(:per_page => 5))) +
        content_tag(:li, link_to('10', params.merge(:per_page => 10))) +
        content_tag(:li, link_to('20', params.merge(:per_page => 20)))
      end
    end
  end

end
