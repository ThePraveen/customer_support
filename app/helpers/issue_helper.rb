module IssueHelper
  def create_issue(create_params)
    Issue.create!(extract_params(create_params, Issue::CREATE_KEYS))
  rescue Exception => e
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))
    nil
  end


  def update_issue(issue, update_params)
    issue = Issue.find(issue) if issue.class != Issue
    issue.update(extract_params(update_params, [:status, :executive_id]))
    issue
  rescue Exception => e
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))
    nil
  end

  def search_issues(search_params)
    conditions  = extract_params(search_params, [:customer_id, :executive_id])
    Issue.where(conditions)
  end

  def find_issue(id)
    Issue.find(id)
  end

  def add_comment_to_issue(issue, comment_params)
    issue = Issue.find(issue) if issue.class != Issue
    issue.comments.create!(extract_params(comment_params, Comment::CREATE_KEYS))
  rescue Exception => e
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))
    nil
  end

end
