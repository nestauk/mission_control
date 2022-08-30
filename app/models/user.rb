class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[okta]

  belongs_to :contact

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
      user.save
    end

    user
  end
end
