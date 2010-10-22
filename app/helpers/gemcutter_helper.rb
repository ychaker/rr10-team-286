module GemcutterHelper
  def display_info(search_result, attribute)
    "<strong>#{attribute.titleize}:</strong> #{search_result.send(attribute)}"
  end
  
  def display_dependencies(search_result, attribute)
    "<strong>#{attribute.titleize}:</strong> <br/> " + search_result.send(attribute).inject("") { |display, dependency| 
      display += link_to("#{dependency[:name]} #{dependency[:requirements]}", :controller => 'gemcutter', :action => 'rubygem', :name => dependency[:name])
      display += image_tag("/images/deprecated-stamp-straight.png", :border => 0, :width => 150, :height => 25) if Vote.deprecated?(dependency[:name])
      display += "<br />"
    }
  end
  
  def display_url(search_result, attribute)
    "<strong>#{attribute.titleize}:</strong> " + link_to(search_result.send(attribute), search_result.send(attribute))
  end
  
  def vote_count name
    "<red>(-#{Vote.by_name(name).count})</red>" unless Vote.by_name(name).count.blank? || Vote.by_name(name).count == 0
  end
  
  def display_dependency dependency
    link_to "#{dependency.name}, #{dependency.version}", :controller => 'gemcutter', :action => 'rubygem', :name => dependency.name 
  end
  
  def display_last_commit_date date
    unless date.blank?
       Time.parse(date).strftime("%m/%d/%Y %H:%M:%S") + " (" + time_ago_in_words(Time.parse(date)) + " ago)"
    end
  end
end
