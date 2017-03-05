module Api::V1
  class IssuesController < ApplicationController
    include IssueHelper

    # POST /issues
    api :POST, 'api/issues', "Create a new issue"
    description "Customer uses this controller to create new issue"

    param :customer_id, String, :desc => "Payload Param: is of the customer creatung this issue"
    param :title, String, :desc => "Payload Param: subject of the issue"
    param :description, String, :desc => "Payload Param: Description of the issue"

    example '

          ------- SAMPLE REQUEST and RESPONSES --------

          1. success: 201
          REQUEST
          {
            "customer_id": 1,
            "title": "some title",
            "description": "Some big description"
          }
          RESPONSE
          {
            "status": "success",
            "message": "Issue Created Successfully",
            "data": {
              "issue": {
                "id": 14,
                "customer_id": 1,
                "executive_id": null,
                "status": "created",
                "title": "some title",
                "description": "Some big description",
                "created_at": "2017-03-05T09:09:44.000Z",
                "updated_at": "2017-03-05T09:09:44.000Z"
              }
            }
          }
          '

    def create
      logger.info "Create issue called with params: #{params.inspect}"
      @issue = create_issue(params)
      if @issue.present?
        render json: {
            status: "success",
            message: "Issue Created Successfully",
            data: {
                :issue => @issue
            }
        }, status: :created and return
      else
        render json: {status: "error", message: "Issue with request format"}, status: :bad_request and return
      end
    rescue Exception => e
      logger.error(e.message)
      logger.error(e.backtrace.join("\n"))
      render json: {status: "error", message: e.message}, status: :internal_server_error
    end

    api :PUT, 'api/issues/:id', "Update any issue."
    description "Update an issue with id passed. Used to assign executive and change the status"

    param :executive_id, String, :desc => "Payload Param: executive id to assign to"
    param :status, String, :desc => "Payload Param: status"

    example '

          ------- SAMPLE REQUEST and RESPONSES --------

          1. success: 201
          REQUEST
          {
            "status": "resolved",
            "executive_id": 2,
          }
          RESPONSE
          {
            "status": "success",
            "message": "Issue Updated Successfully",
            "data": {
              "issue": {
                "id": 14,
                "customer_id": 1,
                "executive_id": 2,
                "status": "resolved",
                "title": "some title",
                "description": "Some big description",
                "created_at": "2017-03-05T09:09:44.000Z",
                "updated_at": "2017-03-05T09:09:44.000Z"
              }
            }
          }
          '
    def update
      @issue = Issue.find(params[:id])
      @issue = update_issue(@issue, params)
      render json: {status: "success",  message: "Issue Updated Successfully", data: @issue}, status: :ok and return
    rescue Exception => e
      logger.error(e.message)
      logger.error(e.backtrace.join("\n"))
      render json: {status: "failure", message: e.message}, status: :bad_request
    end



    api :GET, 'api/issues', "Search for issues"
    description "Search for issues with status, customer_id and other filter"

    param :executive_id, String, :desc => "Query Param: executive id "
    param :customer_id, String, :desc => "Query Param: customer id "
    param :status, String, :desc => "Payload Param: status"

    def index
      @issues = search_issues(params)
      render json: {
          status: "success",
          message: "Issues found",
          data: { issues: @issues}
      }, status: :ok and return
    end

    api :GET, 'api/issues/:id', "GET an issue with id"
    description "Find the issue with id passed in path param"

    param :id, String, :desc => "Payload Param: id of the issue"

    def show
      @issue = Issue.find(params[:id])
      render json: {status: "success",  message: "Issue Updated Successfully", data: @issue}, status: :ok and return
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
