# == Schema Information
#
# Table name: materials
#
#  id            :integer          not null, primary key
#  file          :string(255)
#  name          :string(255)
#  report_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  conference_id :integer
#  user_id       :integer
#  state         :string(255)
#

class Material < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :file, :name, :report_id, :user_id, :conference_id

  ## associations
  belongs_to :report
  belongs_to :conference
  belongs_to :user

  ## plugins
  audited
  mount_uploader :file, MaterialUploader

  state_machine :initial => :pending do
    event :approve do
      transition :pending => :approved
    end
  end

  ## callbacks
  ## validations
  validates :name, presence: true
  validates :file, presence: true
  validates :conference_id, presence: true
  validates :user_id, presence: true

  ## named_scopes
  ## class methods
  public
  protected
  private
end
