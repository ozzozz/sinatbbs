require_relative './start.rb'
require 'rspec'
require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.default_formatter = 'doc'
  config.order = :random

  def app
    Sinatra::Application
  end
end

describe 'Sinatbbs' do
  context "GET '/style.css'" do
    it "should return the stylesheet" do
      get '/style.css'

      expect(last_response).to be_ok
      expect(last_response.status).to eq(200)
    end
  end

  context "GET '/'" do
    it 'should return the comments of all authors' do
      get '/'

      expect(last_response).to be_ok
      expect(last_response.status).to eq(200)
      expect(last_response.body).to_not eq('')
    end
  end

  context "PUT '/comment'" do
    it 'should create new comment' do
      put '/comment', name: 'foo', title: 'bar', message: 'baz'

      expect(last_response.status).to eq(302)
    end
  end
end
