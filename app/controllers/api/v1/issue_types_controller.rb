module Api::V1
  class IssueTypesController < ApplicationController
    before_action :set_issue_type, only: [:show, :update, :destroy]

    # GET /issue_types
    def index
      @issue_types = IssueType.all

      render json: @issue_types
    end

    # GET /issue_types/1
    def show
      render json: @issue_type
    end

    # POST /issue_types
    def create
      @issue_type = IssueType.new(issue_type_params)

      if @issue_type.save
        render json: @issue_type, status: :created, location: @issue_type
      else
        render json: @issue_type.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /issue_types/1
    def update
      if @issue_type.update(issue_type_params)
        render json: @issue_type
      else
        render json: @issue_type.errors, status: :unprocessable_entity
      end
    end

    # DELETE /issue_types/1
    def destroy
      @issue_type.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue_type
      @issue_type = IssueType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def issue_type_params
      params.require(:issue_type).permit(:name)
    end
  end
end
