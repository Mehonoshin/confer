class Participant < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :conference_id, :state, :user_id

  ## associations
  belongs_to :user
  belongs_to :conference

  ## plugins

  ## callbacks

  ## validations

  ## named_scopes

  ## class methods

  public
  protected
  private
end
