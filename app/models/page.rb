# == Schema Information
#
# Table name: pages
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  body          :text
#  permalink     :string(255)
#  conference_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Page < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :body, :conference_id, :permalink, :title

  ## associations
  belongs_to :conference

  ## plugins

  ## callbacks

  ## validations
  validates :body, presence: true
  validates :permalink, presence: true, uniqueness: { scope: :conference_id }

  ## named_scopes

  ## class methods

  public

  def to_param
    permalink
  end

  protected

  private
end
