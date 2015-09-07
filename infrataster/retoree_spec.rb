require 'spec_helper'

describe server(:retoree) do
  describe "camo" do
    path = '/5438e4d9af81d23c5c132435bdac96c5e7afdd75/687474703a2f2f696d672e736f7261682e6a702f722f2545332538312538362545332538302539432e6a7067'
    host = 'camo.kosendj-bu.in'

    describe http("http://#{host}#{path}") do
      it "returns 200 OK with image/jpeg" do
        expect(response.status).to eq 200
        expect(response.headers['content-type']).to eq 'image/jpeg'
      end

      it "returns XHR level 2 headers" do
        expect(response.headers['access-control-allow-origin']).to eq '*'
        expect(response.headers['access-control-allow-methods']).to include('GET')
      end
    end
  end

  describe "gjcase_storage" do
    host = 'gjcase-storage.kosendj-bu.in'

    describe "static" do
      path = '/v1/c3/6c/ffb9aeb7ab855ff343973cbbc2c427ef263a232337c2e2a649fa628a87a16cc3.gif'

      describe http("http://#{host}#{path}") do
        it "returns 200 OK with image/gif" do
          expect(response.status).to eq 200
          expect(response.headers['content-type']).to eq 'image/gif'
        end

        it "returns XHR level 2 headers" do
          expect(response.headers['access-control-allow-origin']).to eq '*'
          expect(response.headers['access-control-allow-methods']).to include('GET')
        end
      end

    end

  end
end
