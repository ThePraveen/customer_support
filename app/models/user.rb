class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable

  include DeviseTokenAuth::Concerns::User

  has_one :customer, :dependent => :destroy
  has_one :admin, :dependent => :destroy
  has_one :executive, :dependent => :destroy

  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles

  has_many :permissions, :through => :roles

  def roles_array
    roles.map {|role| role.name}
  end

  def add_roles(new_roles_to_be_added, params={})
    new_roles_to_be_added.each do |role_to_added|
      unless self.roles_array.include? role_to_added
        new_role = Role.find_by_name(role_to_added)
        if new_role.present?
          self.roles << new_role
          case role_to_added
            when "customer"
              Customer.create!(params.merge!({:user_id => self.id}))
            when "executive"
              Executive.create!(params.merge!({:user_id => self.id}))
            when "admin"
              Admin.create!(params.merge!({:user_id => self.id}))
          end
        end
      end
    end
  end

end
