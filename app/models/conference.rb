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
#  state             :string(255)
#  description       :text
#  logo              :string(255)
#  theme             :string(255)
#  user_id           :integer
#  notify_email      :string(255)
#  address           :string(255)
#  phone             :string(255)
#  public_email      :string(255)
#  additional_info   :text
#  modules           :text
#

class Conference < ActiveRecord::Base
  THEMES = ["amelia.min", "cerulean.min", "cosmo.min", "cyborg.min", "journal.min", "readable.min", "salate.min", "simplex.min", "spruce.min", "superhero.min", "united.min"]
  MODULES = ["news", "reports", "participants", "contacts", "personal_page"]

  ## included modules & attr_*
  attr_accessible :end_date, :max_guests, :name, :start_date, :user_id, :domain, :registrable_until, :description, :logo, :theme, :notify_email, :address, :phone, :public_email, :additional_info, :modules
  serialize :modules, Array

  ## associations
  belongs_to :user
  has_many :participants
  has_many :guests, through: :participants, source: :user

  has_many :organizers
  has_many :stuff, through: :organizers, source: :user

  has_many :reports, dependent: :destroy
  has_many :news_articles, dependent: :destroy

  has_many :feedbacks

  ## plugins
  audited associated_with: :user
  mount_uploader :logo, LogoUploader

  state_machine :initial => :pending do
    event :approve do
      transition :pending => :approved
    end

    after_transition :pending => :approved, :do => :notify_creator
  end

  ## callbacks
  after_create :add_owner
  after_create :force_domain_to_downcase

  ## validations
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :domain, presence: true, uniqueness: true, format: { with: /^[a-zA-Z0-9-]*$/ }
  validates :notify_email, format: { with: /\A([^@\s]+)@((?:[-a-z1-9]+\.)+[a-z]{2,})\Z/i }, allow_blank: true
  validates :public_email, format: { with: /\A([^@\s]+)@((?:[-a-z1-9]+\.)+[a-z]{2,})\Z/i }, allow_blank: true
  validate :end_date_greater_than_start_date
  validate :registration_date_less_than_end_date

  ## named_scopes
  scope :future, ->(current_time) { where("end_date >= ?", current_time) }
  scope :past, ->(current_time) { where("end_date < ?", current_time) }
  scope :with_description, where("description IS NOT NULL")
  scope :random, order("RANDOM()")

  ## class methods

  public

  def module_enabled?(site_module)
    modules.include?(site_module)
  end

  def notification_email
    notify_email.present? ? notify_email : user.email
  end

  def has_guest?(user)
    !participants.where(user_id: user.id).empty?
  end

  def registration_open?
    if registrable_until
      Time.now <= registrable_until && Time.now <= end_date
    else
      Time.now <= end_date
    end
  end

  def guests_limit?
    max_guests.present?
  end

  def guests_limit_reached?
    guests.count == max_guests
  end

  protected
  private

    def force_domain_to_downcase
      self.domain = domain.downcase
      save
    end

    def notify_creator
      ConferenceMailer.conference_approved(self, organizers.first).deliver
    end

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
