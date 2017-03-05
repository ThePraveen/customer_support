module CommentHelper
  
  def update_comment(comment, update_params)
    comment = Comment.find(comment) if comment.class != Comment
    comment.update(update_params)
  rescue Exception => e
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))
    nil
  end

  def add_reply_to_comment(comment, reply_params)
    comment = Comment.find(comment) if comment.class != Comment
    comment.replies.create!(reply_params)
  rescue Exception => e
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))
    nil

  end

end