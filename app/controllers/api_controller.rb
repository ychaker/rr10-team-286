class ApiController < ApplicationController

  def rubygem
    name = params[:name]
    count = Vote.by_name(name).count
    deprecated = Vote.deprecated?(name)
    response = {:name => name, :vote_count => count, :deprecated => deprecated }
    respond_to do |format|
      format.html { render :json  => response }
      format.json { render :json  => response }
      format.xml  { render :xml   => response }
    end
  end
  
  def deprecated
    response = {:gems => Vote.deprecated }
    respond_to do |format|
      format.html { render :json  => response }
      format.json { render :json  => response }
      format.xml  { render :xml   => response }
    end
  end
end
