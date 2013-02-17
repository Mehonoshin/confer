# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  body            :text
#  permalink       :string(255)
#  conference_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  display_in_menu :boolean          default(FALSE)
#

class Page < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :body, :conference_id, :permalink, :title, :display_in_menu

  ## associations
  belongs_to :conference

  ## plugins

  ## callbacks

  ## validations
  validates :body, presence: true
  validates :permalink, presence: true, uniqueness: { scope: :conference_id }, format: { with: /^[a-zA-Z0-9-]*$/ }

  ## named_scopes
  scope :in_menu, where(display_in_menu: true)

  ## class methods

  public

  def to_param
    permalink
  end

  protected

  private
end
