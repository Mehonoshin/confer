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
#

class User < ActiveRecord::Base
  ## included modules & attr_*
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :confirmed_at

  ## associations
  has_many :participations, class_name: "Participant", dependent: :destroy
  has_many :takes_part, through: :participations, source: :conference, dependent: :destroy

  has_many :organizer_roles, class_name: "Organizer", dependent: :destroy
  has_many :organized, through: :organizer_roles, source: :conference, dependent: :destroy

  ## plugins

  ## callbacks

  ## validations

  ## named_scopes

  ## class methods

  public

  def registred?
    !new_record?
  end

  def admin?
    service_admin
  end

  def admin!
    update_attribute("service_admin", true)
  end

  protected
  private
end
