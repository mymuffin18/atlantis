module Api
  module V1
    class AdminReportsController < ApplicationController
      before_action :authenticate_admin!

      def index
        reports = DisasterReport.includes(:user).where(approved: true)
        arr = []
        reports.each do |r|
          arr.push(serialize_report(r))
        end
        render json: arr, status: :ok
      end

      def show
        report = DisasterReport.find(params[:id])

        render json: serialize_report(report), status: :ok
      end

      def pending_reports
        reports = DisasterReport.includes(:user).where(approved: false)
        arr = []
        reports.each do |r|
          arr.push(serialize_report(r))
        end
        render json: arr, status: :ok
      end

      def approve
        report = DisasterReport.find(params[:id])
        if report.approved?
          report.approved = false
          report.approved_by = nil
        else
          report.approved = true
          report.approved_by = "#{current_admin.first_name} #{current_admin.last_name}"
        end
        report.save

        render json: serialize_report(report), status: :ok
      end

      def destroy
        report = DisasterReport.find(params[:id])
        report.destroy!
        head :no_content
      end

      private

      def serialize_report(report)
        imgs = []
        report.images.each do |img|
          imgs.push(url_for(img))
        end
        {
          id: report.id,
          latitude: report.latitude,
          longitude: report.longitude,
          date_occured: report.date_occured,
          disaster_level: report.disaster_level,
          description: report.description,
          approved_by: report.approved_by,
          approved: report.approved,
          user: {
            id: report.user.id,
            fullname: "#{report.user.first_name} #{report.user.last_name}",
            profile_pic: url_for(report.user.profile_pic),
            warning: report.user.warning
          },
          images: imgs,
          disaster: {
            id: report.disaster_id,
            disaster_type: report.disaster.disaster_type,
            avatar: url_for(report.disaster.avatar)
          },
          votes: report.get_upvotes.size

        }
      end
    end
  end
end
