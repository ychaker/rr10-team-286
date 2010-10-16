require 'gemcutter'

class GemcutterController < ApplicationController

  def search
    @gems = Gemcutter.search(params[:q]) unless params[:q].blank?
    @recent = Vote.recent
  end
  
  def rubygem
     @gem = Gemcutter.rubygem(params[:name]) unless params[:name].blank?
  end

end
