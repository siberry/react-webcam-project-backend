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
  JSON.parse(response)["result"]["webcams"]
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


webcam = get_JSON_response('https://webcamstravel.p.rapidapi.com/webcams/list/webcam=1511477795?lang=en&show=webcams%3Aimage%2Clocation%2Cplayer').first

create_webcam_instance(webcam, true)

# t.string :title, t.string :player_url, t.string :img_url, t.integer :api_id, t.boolean :featured, t.string :country, t.string :continent, t.string :town


# continents = [[term_type: "continent", search_term: "Africa", link_term: "AF"],
  # [term_type: "continent", search_term: "Antarctica", link_term: "AN"],
  # [term_type: "continent", link_term: "AS", search_term: 'Asia'],
  # [term_type: "continent", link_term: "EU", search_term: 'Europe'],
  # [term_type: "continent", link_term: "NA" , search_term: 'North America'],
  # [term_type: "continent", link_term: "OC" , search_term: 'Oceania'],
  # [term_type: "continent", link_term: "SA" , search_term: 'South America']]
# continents.each do |continent|
  # SearchTerm.create(continent)
# end
