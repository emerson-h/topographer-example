require 'sinatra/base'

class FakeServiceApi < Sinatra::Base
  get '/orders/:id' do |id|
    json_file = File.join(__dir__, '..', 'fixtures', 'order_items.json')
    json_data = JSON.parse(File.open(json_file, 'rb').read)

    content_type :json
    status 200
    JSON.generate(json_data[id])
  end
end
