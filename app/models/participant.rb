# == Schema Information
#
# Table name: participants
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  conference_id :integer
#  state         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Participant < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :conference_id, :state, :user_id

  ## associations
  belongs_to :user
  belongs_to :conference
  has_many :reports, dependent: :destroy

  ## plugins
  state_machine :initial => :new do
    event :approve do
      transition :new => :approved
    end
  end

  ## callbacks

  ## validations
  validates :user_id, presence: true
  validates :conference_id, presence: true

  ## named_scopes

  ## class methods

  public
  protected
  private
end
