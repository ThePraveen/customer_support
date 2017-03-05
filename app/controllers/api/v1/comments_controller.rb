class Api::V1::CommentsController < ApplicationController
  def index

  end

  def show

  end

  def update
    comment = Comment.find(params[:id])
    issue = update_comment(comment, params)
    render json: {status: "success",  message: "Issue Updated Successfully", data: issue}, status: :ok and return
  rescue Exception => e
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))
    render json: {status: "failure", message: e.message}, status: :bad_request
  end


  # def add_reply
  #   comment = Comment.find(params[:id])
  #   comment = add_reply_to_comment(comment, params)
  #   render json: {status: "success",  message: "Reply Added Successfully", data: comment}, status: :ok and return
  # rescue Exception => e
  #   logger.error(e.message)
  #   logger.error(e.backtrace.join("\n"))
  #   render json: {status: "failure", message: e.message}, status: :bad_request
  # end

end
