# == Schema Information
#
# Table name: feedbacks
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  email         :string(255)
#  title         :string(255)
#  body          :text
#  conference_id :integer
#  state         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Feedback < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :body, :conference_id, :email, :state, :title, :user_id

  ## associations
  belongs_to :user
  belongs_to :conference

  ## plugins
  state_machine :initial => :unread do
    event :read do
      transition :unread => :read
    end
  end

  ## callbacks
  after_create :notify_conference_owner

  ## validations
  validates :user_id, presence: true, if: "email.nil?"
  validates :email,
    presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i },
    if: "user_id.nil?"
  validates :title, presence: true
  validates :body, presence: true

  ## named_scopes

  ## class methods

  public

    def customer_email
      email.present? ? email : user.email
    end

  protected

  private

    def notify_conference_owner
      FeedbackMailer.new_feedback(conference.notification_email, title, body, user, conference).deliver
    end
end
