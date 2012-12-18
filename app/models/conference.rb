# == Schema Information
#
# Table name: conferences
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  start_date        :datetime
#  end_date          :datetime
#  max_guests        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  domain            :string(255)
#  registrable_until :datetime
#

class Conference < ActiveRecord::Base
  ## included modules & attr_*
  attr_accessible :end_date, :max_guests, :name, :start_date, :user_id, :domain, :registrable_until
  attr_accessor :user_id

  ## associations
  has_many :participants
  has_many :guests, through: :participants, source: :user

  has_many :organizers
  has_many :stuff, through: :organizers, source: :user

  ## plugins

  ## callbacks
  after_create :add_owner

  ## validations
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :domain, presence: true, uniqueness: true
  validate :end_date_greater_than_start_date
  validate :registration_date_less_than_end_date

  ## named_scopes

  ## class methods

  public

  def registration_open?
    Time.now <= registrable_until
  end

  protected
  private

    def registration_date_less_than_end_date
      if end_date.present? && registrable_until.present? && registrable_until > end_date
        errors.add(:registrable_until, I18n.t('conference.validations.registrable_until_must_be_less_or_equel_than_end_date'))
      end
    end

    def end_date_greater_than_start_date
      if start_date.present? && end_date.present? && start_date > end_date
        errors.add(:start_date, I18n.t('conference.validations.start_date_should_be_less_than_end_date'))
        errors.add(:end_date, I18n.t('conference.validations.end_date_should_be_greater_than_start_date'))
      end
    end

    def add_owner
      organizers.create!(user_id: user_id, role: "owner")
    end
end
