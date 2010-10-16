module GemcutterHelper
  def display_info(search_result, attribute)
    "<strong>#{attribute.titleize}:</strong> #{search_result.send(attribute)}"
  end
  
  def display_dependencies(search_result, attribute)
    "<strong>#{attribute.titleize}:</strong> <br/> " + search_result.send(attribute).inject("") { |display, dependency| display += "#{dependency[:name]} #{dependency[:requirements]} <br />"}
  end
end
