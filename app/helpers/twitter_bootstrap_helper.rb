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

end