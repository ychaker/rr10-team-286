module GemcutterHelper
  def display_info(search_result, attribute)
    "<strong>#{attribute.titleize}:</strong> #{search_result.send(attribute)}"
  end
  
  def display_dependencies(search_result, attribute)
    "<strong>#{attribute.titleize}:</strong> <br/> " + search_result.send(attribute).inject("") { |display, dependency| display += "#{dependency[:name]} #{dependency[:requirements]} <br />"}
  end
  
  def display_url(search_result, attribute)
    "<strong>#{attribute.titleize}:</strong> " + link_to(search_result.send(attribute), search_result.send(attribute))
  end
  
  def vote_count name
    "<red>(-#{Vote.by_name(name).count})</red>" unless Vote.by_name(name).count.blank? || Vote.by_name(name).count == 0
  end
  
end
