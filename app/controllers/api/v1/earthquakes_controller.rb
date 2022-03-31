module Api
  module V1
    class EarthquakesController < ApplicationController
      before_action :authenticate_user!

      def index
        data = Usgs::Client.earthquake_data

        render json: data, status: :ok
      end
    end
  end
end
