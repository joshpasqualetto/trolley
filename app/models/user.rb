class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :token_authenticatable, :recoverable, :rememberable,
         :trackable, :confirmable, :validateable

  has_many :assets
  has_and_belongs_to_many :roles

  attr_accessible :email, :password, :password_confirmation, :role_ids, :remember_me

  def role?(role)
    !!self.roles.find_by_name(Role.sanitize(role))
  end
end
