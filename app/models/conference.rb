class Conference < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :end_date, :max_guests, :name, :start_date

  ## associations
  has_many :participants
  has_many :guests, through: :participants, source: :user

  ## plugins

  ## callbacks

  ## validations
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  ## named_scopes

  ## class methods

  public
  protected
  private
end
