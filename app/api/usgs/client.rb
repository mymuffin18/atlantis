require 'faraday'

module Usgs
  class Client
    def self.earthquake_data
      response = Faraday.get('https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&minmagnitude=5')

      body = JSON.parse(response.body)
      arr = []
      body['features'].each do |data|
        info = {
          id: data['id'],
          magnitude: data['properties']['mag'],
          place: data['properties']['place'],
          latitude: data['geometry']['coordinates'][0],
          longitude: data['geometry']['coordinates'][1],
          depth: data['geometry']['coordinates'][2]
        }
        arr.push(info)
      end

      arr
    end
  end
end
