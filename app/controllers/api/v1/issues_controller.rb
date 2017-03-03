module Api::V1
  class IssuesController < ApplicationController
    include IssueHelper

    # POST /issues
    def create
      logger.info "Create issue called with params: #{params.inspect}"
      issue = create_issue(params)
      if issue.present?
        render json: {
            status: "success",
            message: "Issue Created Successfully",
            data: {
                :issue => issue
            }
        }, status: :created and return
      else
        render json: {status: "error", message: e.message}, status: :bad_request and return
      end
    rescue Exception => e
      logger.error(e.message)
      logger.error(e.backtrace.join("\n"))
      render json: {status: "error", message: e.message}, status: :internal_server_error
    end

    # PATCH/PUT /issues/1
    def update
      issue = Issue.find(params[:id])
      issue = update_issue(issue, params)
      render json: {status: "success",  message: "Issue Updated Successfully", data: issue}, status: :ok and return
    rescue Exception => e
      logger.error(e.message)
      logger.error(e.backtrace.join("\n"))
      render json: {status: "failure", message: e.message}, status: :bad_request
    end



    # GET /issues
    def index
      issues = search_issues(params)
      render json: {
          status: "success",
          message: "Issues found",
          data: { issues: issues}
      }, status: :ok and return
    end

    # GET /issues/1
    def show
      issue = Issue.find(params[:id])
      render json: {status: "success",  message: "Issue Updated Successfully", data: issue}, status: :ok and return
    end

    def add_comment
      issue = Issue.find(params[:id])
      issue = add_comment_to_issue(issue, params)
      render json: {status: "success",  message: "Issue Updated Successfully", data: issue}, status: :ok and return
    rescue Exception => e
      logger.error(e.message)
      logger.error(e.backtrace.join("\n"))
      render json: {status: "failure", message: e.message}, status: :bad_request
    end
  end
end