class SearchesController < ApplicationController
  def search
  end

  def foursquare
  begin
      @response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '2UMEHQHZXDW2M4ZJOJWB25CTN4PNB4OP3DGOZGLTGOKXRGDJ'
        req.params['client_secret'] = 'MNMPNC2JOMG4ARXFPHBRNAJKUWRB15WQVB4LOAYZLLZDVYDK'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
      end

      body = JSON.parse(@response.body)
      if @response.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end
