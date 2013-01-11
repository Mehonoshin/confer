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
  attr_accessible :conference_id, :role, :role_description, :user_id

  ## associations
  belongs_to :user
  belongs_to :conference
  has_many :news_articles, dependent: :destroy

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
