class ConferencesController < ApplicationController
  # TODO
  # на странице списка конференций сделать вкладки бутстеповые типа
  # Все конференции, Прошедшие, будущие
  # и js'om без перезагрузок страницы менять содержимое
  load_and_authorize_resource

  def index
    @conferences = Conference.all
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
