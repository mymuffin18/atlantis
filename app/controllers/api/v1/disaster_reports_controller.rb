module Api
  module V1
    class DisasterReportsController < ApplicationController
      before_action :authenticate_user!

      def index
        disaster_reports = DisasterReport.includes(:user)

        render json: disaster_reports, status: :ok
      end

      def create
        disaster_report = current_user.disaster_reports.build(report_params)
        if disaster_report.save
          render json: disaster_report, status: :created
        else
          render json: disaster_report.errors, status: :unprocessable_entity
        end
      end


      private
      def report_params
        params.permit(:latitude, :longitude, :disaster_level, :description, :date_occured, :disaster_id, images: [])
      end
    end
  end
end
