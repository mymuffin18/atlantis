module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_admin!

      def index
        users = User.all
        arr = []
        users.each do |d|
          arr.push(serialize_user(d))
        end
        render json: arr, status: :ok
      end

      def add_warning
        user = User.find(params[:id])
        user.dateOfSuspension = Time.zone.today if user.warning >= 3
        user.warning += 1
        user.save
        render json: serialize_user(user), status: :ok
      end

      def clear_warning
        user = User.find(params[:id])
        user.warning = 0
        user.dateOfSuspension = nil
        user.save

        render json: serialize_user(user), status: :ok
      end

      private

      def serialize_user(user)
        {
          id: user.id,
            first_name: user.first_name,
            last_name: user.last_name,
            email: user.email,
            num_pending_report: user.disaster_reports.where(approved: false).count,
            num_approved_report: user.disaster_reports.where(approved: true).count,
            warning: user.warning,
            dateOfSuspension: user.dateOfSuspension
        }
      end
    end
  end
end
