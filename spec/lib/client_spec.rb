require "spec_helper"
require 'json'

describe Client do
  describe "#get_summoner" do
    let(:response) {
      { foqq: {
         id: 22796672,
         name: "Foqq",
         profileIconId: 660,
         revisionDate: 1414617357000,
         summonerLevel: 30
      }
      }
    }

    before do
      stub_request(:get, "https://eune.api.pvp.net/api/lol/eune/v1.4/summoner/1?api_key=test").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => response.to_json, :headers => { 'Content-Type' => 'application/json'})
    end

    it "calls LoL API" do
      expect { subject.get_summoner "1" }.not_to raise_error
    end

    it "returns a summoner entity" do
      expect(subject.get_summoner("1")).to be_kind_of(Summoner)
    end

    it "returns an entity with correct values" do
      expect(subject.get_summoner("1").name).to eq "Foqq"
      expect(subject.get_summoner("1").summoner_level).to eq 30
    end
  end
end
