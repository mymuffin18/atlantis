module Api
    module V1
        class LocationsController < ApplicationController
            before_action :authenticate_user!

            

            def index
                locations = current_user.locations
                render json: locations, status: :ok
            end

            def show
                location = Location.find(params[:id])
                render json: serialize_location(location), status: :ok
            end

            def create
                location = current_user.locations.build(location_params)
                if location.save
                  render json: serialize_location(location), status: :created
                else
                  render json: location.errors, status: :unprocessable_entity
                end
            end

            def update
                location = Location.find(params[:id])
                if location.update(params.permit(:locname))
                  render json: serialize_location(location), status: :ok
                else
                  render json: location.errors, status: :unprocessable_entity
                end
              end
        
              def destroy
                location = Location.find(params[:id])
                location.destroy!
                head :no_content
              end

            private
            def location_params
                params.permit(:locname, :latitude, :longitude)
            end
            def serialize_location(location)
                {
                  id: location.id,
                    locname: location.locname,
                    latitude: location.latitude,
                    longitude: location.longitude
                }
            end
        end
    end
end
