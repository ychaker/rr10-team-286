class VotesController < ApplicationController
  before_filter :has_access?, :except => [:index, :show]
  
  # GET /votes
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  def show
    @vote = Vote.find(params[:id])
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  def create
    @vote = Vote.new(params[:vote])

    if @vote.save
      redirect_to(:back, :notice => 'Your vote has been registered <br /> Thank you for helping the community, you are a true Rubyist!')
    else
      @vote = Vote.by_user(params[:vote][:user_id]).by_name(params[:vote][:name]).last
      if @vote
        flash[:notice] = 'You have already voted for this gem <br /> Thank you for helping the community, you are a true Rubyist!'
        redirect_to :action => "show", :id => @vote.id
      else
        redirect_to(:back, :error => 'Could not register your vote at the moment, please try again later.')
      end
    end
  end

  # PUT /votes/1
  def update
    @vote = Vote.find(params[:id])

    if @vote.update_attributes(params[:vote])
      redirect_to(@vote, :notice => 'Vote was successfully updated.')
    else
      render :action => "edit" 
    end
  end

  # DELETE /votes/1
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    redirect_to(votes_url)
  end
  
private
  def has_access?
    unless signed_in?
      flash[:error] = 'You must login to vote!'
      redirect_to(:back)
    else
      !params[:id].blank? && current_user.id == Vote.find(params[:id]).user_id
    end
  end
end
