module Api
  module V1
    class DisasterReportsController < ApplicationController
      before_action :authenticate_user!

      def index
        disaster_reports = DisasterReport.includes(:user).where(approved: true).where('date_occured > ?', 30.days.ago)
        reports = []
        disaster_reports.each do |report|
          reports.push(serialize_report_with_votes(report))
        end
        render json: reports, status: :ok
      end

      def show
        disaster_report = DisasterReport.find(params[:id])
        render json: serialize_report_with_votes(disaster_report), status: :ok
      end

      def create
        if current_user.warning >= 3
          render json: { message: 'sorry you are temporarily suspended for spamming wrong reports' }, status: :forbidden
        else
          disaster_report = current_user.disaster_reports.build(report_params)
          disaster_report.images.attach(params[:images])
          if disaster_report.save
            render json: serialize_report_with_votes(disaster_report), status: :created
          else
            render json: disaster_report.errors, status: :unprocessable_entity
          end
        end
      end

      def update
        report = DisasterReport.find(params[:id])
        if report.update(update_params)
          render json: serialize_disaster_report(report), status: :ok
        else
          render json: report.errors, status: :unprocessable_entity
        end
      end

      def destroy
        report = DisasterReport.find(params[:id])
        report.images.purge
        report.destroy!
        head :no_content
      end

      def pending_reports
        reports = DisasterReport.includes(:user).where(approved: false).where('date_occured > ?', 30.days.ago)
        arr = []
        reports.each do |r|
          arr.push(serialize_report_with_votes(r))
        end

        render json: arr, status: :ok
      end

      def vote
        report = DisasterReport.find(params[:id])
        if current_user.voted_for? report
          report.unliked_by current_user
        else
          report.liked_by current_user
        end
        render json: serialize_report_with_votes(report), status: :ok
      end

      def disaster_types
        disasters = Disaster.all

        arr = []
        disasters.each do |d|
          arr.push(serialize_disaster(d))
        end
        render json: arr, status: :ok
      end

      private

      def report_params
        params.permit(:latitude, :longitude, :disaster_level, :description, :date_occured, :disaster_id, images: [])
      end

      def update_params
        params.permit(:description, :disaster_level)
      end

      def serialize_disaster_report(report)
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
          user: {
            id: report.user.id,
            fullname: "#{report.user.first_name} #{report.user.last_name}",
            profile_pic: url_for(report.user.profile_pic)
          },
          images: imgs,
          disaster: {
            id: report.disaster_id,
            disaster_type: report.disaster.disaster_type,
            avatar: url_for(report.disaster.avatar)
          }
        }
      end

      def serialize_disaster(disaster)
        {
          id: disaster.id,
            disaster_type: disaster.disaster_type,
            avatar: url_for(disaster.avatar)
        }
      end

      def serialize_report_with_votes(report)
        is_voted = false
        is_voted = true if current_user.voted_for? report
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
            profile_pic: url_for(report.user.profile_pic)
          },
          images: imgs,
          disaster: {
            id: report.disaster_id,
            disaster_type: report.disaster.disaster_type,
            avatar: url_for(report.disaster.avatar)
          },
          votes: report.get_upvotes.size,
          voted: is_voted
        }
      end
    end
  end
end
