class Organizer < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :conference_id, :role, :role_description, :user_id

  ## associations
  belongs_to :user
  belongs_to :conference

  ## plugins

  ## callbacks

  ## validations
  validates :user_id, presence: true
  validates :conference_id, presence: true
  validates :role, presence: true

  ## named_scopes

  ## class methods
  public
  protected
  private
end
