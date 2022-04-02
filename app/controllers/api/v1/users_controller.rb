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

      def serialize_user(user)
        {
          id: user.id,
            first_name: user.first_name,
            last_name: user.last_name
        }
      end
    end
  end
end
