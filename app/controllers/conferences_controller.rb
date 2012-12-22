class ConferencesController < ApplicationController
  load_and_authorize_resource

  def index
    @all_conferences = Conference.order("start_date DESC")
    @future_conferences = Conference.future(Time.now).order("start_date DESC")
    @past_conferences = Conference.past(Time.now).order("start_date DESC")
  end

  def new
    @conference = Conference.new
  end

  def show
    render :text => Conference.find(params[:id]).to_json
  end

  def create
    attrs = params[:conference].dup
    attrs[:user_id] = current_user.id
    @conference = Conference.create(attrs)
    if @conference.valid?
      redirect_to conference_path(@conference)
    else
      render :new
    end
  end
end
