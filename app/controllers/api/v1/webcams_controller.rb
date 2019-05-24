class Api::V1::WebcamsController < ApplicationController
  def search
    term = params["selectedCountry"]
    url = "https://webcamstravel.p.rapidapi.com/webcams/list/limit=20,0?country=#{term}?lang=en&show=webcams%3Awebcams%2Clocation%2Cplayer%2Cimage"
    response = get_JSON_response(url)
    webcams = response.map { |webcam| create_webcam_instance(webcam) }

    render json: webcams
  end
end
