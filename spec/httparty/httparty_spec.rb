#/spec/httparty/httparty_spec.rb
require 'rails_helper'

describe 'HttParty' do
  it 'HttParty', vcr: { cassette_name: 'jsonplaceholder/posts', :record => :new_episodes } do #utiliza o vcr

    # stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2").
    # with(
    #   headers: {
    #  'Accept'=>'*/*',
    #  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #  'User-Agent'=>'Ruby'
    #   }).
    # to_return(status: 200, body: "", headers: { 'content-type': 'application/json' })

    response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/4')
    content_type = response.headers["content-type"]
    puts content_type
    expect(content_type).to match(/application\/json/)
    
  end
end