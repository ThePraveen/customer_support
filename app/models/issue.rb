class Issue < ApplicationRecord
  belongs_to :customer

  has_many :comments

  validates :title, :description , presence: true

  CREATE_KEYS = [:customer_id, :title, :description]
  UPDATE_KEYS = [:status, :executive_id]

  before_create do |issue|
    self.status ||= "created"
  end

  module Status
    CREATED = "created"
    ASSIGNED = "assigned"
    RESOLVED = "resolved"
  end
end
