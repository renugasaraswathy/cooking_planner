class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook] 

  attr_accessor :sign_up_code       

  has_many :categories  
  has_one :family_member
  has_one :family,:through=>:family_member
  has_many :recipes  
  validates :user_name,:name,:presence=>true
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.user_name=auth.info.email.split('@').first
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name      
    end
  end

  def is_admin?
    if self.user_name=="admin"
      return true
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end        

end
