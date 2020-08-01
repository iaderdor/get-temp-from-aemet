# frozen_string_literal: true

require 'inifile'
require 'json'
require 'net/http'

def send_petition(url_not_parsed)
  url = URI(url_not_parsed)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request['cache-control'] = 'no-cache'
  http.request(request)
end

def extract_response(response_url)
  url = URI(response_url)
  send_petition(url)
end

def update_file(station_data)
  data_dir = File.join(Dir.home, '.temp-from-aemet/', '')
  Dir.mkdir data_dir unless Dir.exist? data_dir

  unless Dir.empty?(data_dir)
    files = Dir.entries(data_dir) - %w[. ..]

    return unless station_data['fint'] > files.max

    files.each do |file|
      File.delete File.join(data_dir, file)
    end
  end

  File.open(File.join(data_dir, (station_data['fint'])), 'w') { |f| f.write station_data['ta'] }
end

# Loads configuration file

conf = IniFile.load('./conf')
apikey = conf['global']['apikey']
station_id = conf['global']['stationID']

url = 'https://opendata.aemet.es/opendata/api/'\
      "observacion/convencional/datos/estacion/#{station_id}?api_key=#{apikey}"

response = send_petition(url)
response_body = JSON.parse(response.read_body)

return unless response_body['estado'] == 200

station_data = JSON.parse(extract_response(response_body['datos']).read_body)

update_file station_data.last
