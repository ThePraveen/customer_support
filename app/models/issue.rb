class Issue < ApplicationRecord
  belongs_to :customer
  # belongs_to :executive
  # belongs_to :issue_type

  has_many :comments

  CREATE_KEYS = [:title, :customer_id, :description]
  UPDATE_KEYS = [:title, :description, :status, :executive_id]

  before_create do |issue|
    self.status ||= "created"
    self.issue_type_id ||= 1
  end

end
