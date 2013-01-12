# == Schema Information
#
# Table name: organizers
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  conference_id    :integer
#  role             :string(255)
#  role_description :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Organizer < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :conference_id, :role, :role_description, :user_id, :email
  attr_accessor :email

  delegate :full_name, to: :user

  ## associations
  belongs_to :user
  belongs_to :conference
  has_many :news_articles, dependent: :destroy

  ## plugins

  ## callbacks
  before_validation :set_user_id, on: :create

  ## validations
  validates :user_id, presence: true
  validates :conference_id, presence: true
  validates :role, presence: true

  ## named_scopes

  ## class methods
  public
  protected
  private

    def set_user_id
      self.user_id = User.find_by_email(email).id if email.present?
    end
end
