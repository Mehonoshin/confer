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
  attr_accessible :conference_id, :state, :user_id, :reports_attributes

  ## associations
  belongs_to :user
  belongs_to :conference
  has_many :reports, dependent: :destroy
  accepts_nested_attributes_for :reports, :reject_if => proc { |attributes| attributes['description'].blank? || attributes["title"].blank? }

  ## plugins
  audited

  state_machine :initial => :new do
    event :approve do
      transition :new => :approved
    end
    after_transition :new => :approved, :do => :notify_user
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

    def notify_user
      ConferenceMailer.participation_approved(conference, user).deliver
    end
end
