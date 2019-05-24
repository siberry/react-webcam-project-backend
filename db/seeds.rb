# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'rest-client'
require 'json'
require 'byebug'

# webcam keys = id, status, title, image, location, player

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
  Webcam.create(title: webcam_object["title"],
  img_url: webcam_object["image"]["daylight"]["preview"],
  player_url: webcam_object["player"]["month"]["embed"],
  api_id: webcam_object["id"],
  country: webcam_object["location"]["country"],
  continent: webcam_object["location"]["continent"],
  region: webcam_object["location"]["region"],
  featured: featured)
end


# webcam = get_JSON_response('https://webcamstravel.p.rapidapi.com/webcams/list/webcam=1511477795?lang=en&show=webcams%3Aimage%2Clocation%2Cplayer').first

# create_webcam_instance(webcam, true)

def get_countries(offset)
  base = 'https://webcamstravel.p.rapidapi.com/webcams/list/limit=50,'
  modifier = '?property=hd?lang=en&show=webcams%3Aimage%2Clocation%2Cplayer'
  countries = []
  get_JSON_response(base + offset.to_s + modifier).each { |webcam|
    countries << webcam["location"]["country"]
  }
  countries.uniq
end

offset = 0
countries = []

while offset < 32369
  countries << get_countries(offset)
  offset += 50
end

hdCountries = countries.flatten.uniq
puts hdCountries.length
puts hdCountries.sort
