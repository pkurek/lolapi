require 'lol'

class Client
  attr_reader :engine

  def initialize(config = {})
    @engine = config.fetch(:engine) { default_engine }
  end

  def get_summoner(id)
    summoner = engine.summoner.get(id).first

    Summoner.new(summoner.name, summoner.summoner_level)
  end

  private

  def default_engine
    Lol::Client.new(ENV['LOL_API'], region: ENV['LOL_REGION'])
  end
end
