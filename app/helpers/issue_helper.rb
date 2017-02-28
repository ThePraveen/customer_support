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
    issue.update(update_params)
  rescue Exception => e
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))
    nil
  end

  def search_issues(search_params)
    conditions  = extract_params(search_params, [:customer_id])
    Issue.where(conditions)
  end

  def find_issue(id)
    Issue.find(id)
  end

end