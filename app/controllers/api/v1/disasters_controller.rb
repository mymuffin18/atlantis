module Api
  module V1
    class DisastersController < ApplicationController
      before_action :authenticate_admin!

      def index
        disasters = Disaster.all
        arr = []
        disasters.each do |d|
          arr.push(serialize_disaster(d))
        end
        render json: arr, status: :ok
      end

      def show
        disaster = Disaster.find(params[:id])
        render json: serialize_disaster(disaster), status: :ok
      end

      def create
        disaster = Disaster.new(disaster_param)
        if disaster.save
          render json: serialize_disaster(disaster), status: :created
        else
          render json: disaster.errors, status: :unprocessable_entity
        end
      end

      def update
        disaster = Disaster.find(params[:id])
        if disaster.update(disaster_param)
          render json: serialize_disaster(disaster), status: :ok
        else
          render json: disaster.errors, status: :unprocessable_entity
        end
      end

      def destroy
        disaster = Disaster.find(params[:id])
        disaster.avatar.purge
        disaster.destroy!
        head :no_content
      end

      private

      def disaster_param
        params.permit(:disaster_type, :avatar)
      end

      def serialize_disaster(disaster)
        {
          id: disaster.id,
            disaster_type: disaster.disaster_type,
            avatar: url_for(disaster.avatar)
        }
      end
    end
  end
end
