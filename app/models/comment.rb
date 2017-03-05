class Comment < ApplicationRecord
  belongs_to :issue

  CREATE_KEYS = [:user_id, :issue_id, :body]
end
