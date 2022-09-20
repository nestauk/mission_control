class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  belongs_to :contact
  has_one :person, through: :contact

  validates :first_name, :last_name, presence: true

  def self.from_omniauth(auth)
    user = User.find_or_initialize_by(provider: auth.provider, uid: auth.uid)

    unless user.persisted?
      contact = Contact.find_or_initialize_by(email: auth.info.email)
      contact.first_name = auth.info.first_name
      contact.last_name = auth.info.last_name
      contact.save

      user.contact = contact
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.save!
    end

    user
  end

  def name
    "#{first_name} #{last_name}"
  end
end
