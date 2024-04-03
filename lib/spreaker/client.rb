module Spreaker
  class Client
    attr_reader :connection

    def initialize(access_token: ENV["SPREAKER_ACCESS_TOKEN"])
      @access_token = access_token
      retry_options = {
        max: 2,
        interval: 0.05,
        interval_randomness: 0.5,
        backoff_factor: 2,
        retry_statuses: [429]
      }
      @connection = Faraday.new(url: "https://api.spreaker.com") do |conn|
        conn.request :retry, retry_options
        conn.request :authorization, "Bearer", @access_token
      end
    end

    def me
      return @me if @me

      properties = JSON.parse(connection.get("/v2/me").body)["response"]["user"]
      @me = Spreaker::User.new(properties: properties)
    end

    def shows
      response = connection.get("/v2/users/#{me.id}/shows").body
      response_hash = JSON.parse(response)
      shows = response_hash["response"]["items"].map do |item|
        show(id: item["show_id"])
      end
    end

    def show(title: nil, id: nil)
      if id
        return Spreaker::Show.new(properties: JSON.parse(connection.get("/v2/shows/#{id}").body)["response"]["show"])
      end

      shows.select { |show| show.title == title }.first
    end

    def update_show(id:, properties:)
      response = connection.post("/v2/shows/#{id}") do |req|
        req.body = URI.encode_www_form(properties)
      end
      Spreaker::Show.new(properties: JSON.parse(response.body)["response"]["show"])
    end

    def episodes(show:)
      response = connection.get("/v2/shows/#{show.id}/episodes").body
      response_hash = JSON.parse(response)
      episode_list = response_hash["response"]["items"].map do |episode|
        Spreaker::Episode.new(properties: episode)
      end
      while(response_hash.dig("response", "next_url").present? && response_hash["response"]["items"].any?)
        response = connection.get(response_hash["response"]["next_url"]).body
        response_hash = JSON.parse(response)
        episode_list += response_hash["response"]["items"].map do |episode|
          Spreaker::Episode.new(properties: episode)
        end
      end
      episode_list
    end

    def update_episode(id:, properties:)
      response = connection.post("/v2/episodes/#{id}") do |req|
        req.body = URI.encode_www_form(properties)
      end
      properties = JSON.parse(response.body)['response']['episode']
      Spreaker::Episode.new(properties: properties)
    end
  end
end
