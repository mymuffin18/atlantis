require 'faraday'
module Usgs
  class Request
    BASE_URL = 'https://earthquake.usgs.gov/fdsnws/event/1/'

    def connection
      Faraday.new(
        url: BASE_URL
      )
    end
  end
end
