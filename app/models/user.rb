# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmed_at           :datetime
#  confirmation_token     :string(255)
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  service_admin          :boolean          default(FALSE)
#  latitude               :float
#  longitude              :float
#  country                :string(255)
#  city                   :string(255)
#  full_name              :string(255)
#  phone                  :string(255)
#  about                  :text
#

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmed_at           :datetime
#  confirmation_token     :string(255)
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  service_admin          :boolean          default(FALSE)
#  latitude               :float
#  longitude              :float
#  country                :string(255)
#  city                   :string(255)
#  full_name              :string(255)
#  phone                  :string(255)
#  about                  :text
#
class User < ActiveRecord::Base
  ## included modules & attr_*
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :confirmed_at,
    :address, :full_name, :phone, :country, :city, :about, :current_password
  attr_accessor :address, :current_password

  ## associations
  has_many :participations, class_name: "Participant", dependent: :destroy
  has_many :takes_part, through: :participations, source: :conference, dependent: :destroy
  # TODO
  # bronen, fix it
  #has_many :speeches, through: :participations, source: :report, dependent: :destroy

  has_many :organizer_roles, class_name: "Organizer", dependent: :destroy
  has_many :organized, through: :organizer_roles, source: :conference, dependent: :destroy

  ## plugins
  audited
  has_associated_audits

  ## callbacks
  before_save :geocode, if: "address.present?"

  ## validations

  ## named_scopes
  scope :admins, where(service_admin: true)

  ## class methods

  public

  def participates?(conference)
    takes_part.include?(conference)
  end

  def registred?
    !new_record?
  end

  def admin?(conference = nil)
    if conference.nil?
      service_admin
    else
      !Organizer.where(conference_id: conference.id, user_id: id).first.nil?
    end
  end

  def admin!
    update_attribute("service_admin", true)
  end

  def user!
    update_attribute("service_admin", false)
  end

  def address=(value)
    @address = value
  end

  def address
    return @address unless @address.nil?
    return "#{country}, #{city}" if country.present? && city.present?
  end

  protected
  private

    def geocode
      result = Geocoder.search(address).first
      unless result.nil?
        self.latitude = result.coordinates[0]
        self.longitude = result.coordinates[1]
        self.country = result.country
        self.city = result.city
      end
    end
end
