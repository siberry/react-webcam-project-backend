class Api::V1::WebcamsController < ApplicationController
  def search
    term = params["selectedCountry"]
    url = "https://webcamstravel.p.rapidapi.com/webcams/list/limit=20,0?country=#{term}?lang=en&show=webcams%3Awebcams%2Clocation%2Cplayer%2Cimage"
    response = get_JSON_response(url)
    webcams = response.map { |webcam| create_webcam_instance(webcam) }

    render json: webcams
  end

  def get_JSON_response(url) #returns array of webcam objects
    response = RestClient.get(url,
      headers={
        "X-RapidAPI-Host" => "webcamstravel.p.rapidapi.com",
        "X-RapidAPI-Key" => "b3fd4f6beamshfff36b82a27b1eap1031fajsn0f0dc8486196"
      }
    )
    parsed = JSON.parse(response)["result"]["webcams"]
    return parsed
  end

  def create_webcam_instance(webcam_object, featured=false)
    Webcam.find_or_create_by(title: webcam_object["title"],
    img_url: webcam_object["image"]["daylight"]["preview"],
    player_url: webcam_object["player"]["month"]["embed"],
    api_id: webcam_object["id"],
    country: webcam_object["location"]["country"],
    continent: webcam_object["location"]["continent"],
    region: webcam_object["location"]["region"],
    featured: featured)
  end
end
