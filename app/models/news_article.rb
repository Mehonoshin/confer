# == Schema Information
#
# Table name: news_articles
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  body           :text
#  conference_id  :integer
#  participant_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class NewsArticle < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :body, :conference_id, :participant_id, :title

  ## associations
  belongs_to :participant
  belongs_to :conference

  ## plugins

  ## callbacks

  ## validations
  validates :title, presence: true
  validates :body, presence: true

  ## named_scopes

  ## class methods

  public

  protected

  private
end
