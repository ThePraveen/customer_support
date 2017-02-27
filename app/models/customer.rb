class Customer < ApplicationRecord
  belongs_to :user
  has_many :issues
end
