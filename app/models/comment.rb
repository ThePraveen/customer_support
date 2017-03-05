class Comment < ApplicationRecord
  belongs_to :issue

  validates :user_id, :body, presence: true
  CREATE_KEYS = [:user_id, :issue_id, :body]
end
