class Conference < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :end_date, :max_guests, :name, :start_date
  attr_accessor :user_id

  ## associations
  has_many :participants
  has_many :guests, through: :participants, source: :user

  has_many :organizers
  has_many :stuff, through: :organizers, source: :user

  ## plugins

  ## callbacks
  after_create :add_owner

  ## validations
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  ## named_scopes

  ## class methods

  public
  protected
  private

    def add_owner
      organizers.create!(user_id: user_id, role: "owner")
    end
end
