# == Schema Information
#
# Table name: reports
#
#  id             :integer          not null, primary key
#  participant_id :integer
#  conference_id  :integer
#  title          :string(255)
#  description    :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Report < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :conference_id, :description, :title, :participant_id

  ## associations
  belongs_to :participant
  belongs_to :conference

  ## plugins
  state_machine :initial => :pending do
    event :approve do
      transition :pending => :approved
    end

    #after_transition :pending => :approved, :do => :notify_creator
  end

  ## callbacks

  ## validations
  validates :title, presence: true
  validates :description, presence: true
  validates :conference_id, presence: true

  ## named_scopes

  ## class methods

  public

  protected

  private
end
