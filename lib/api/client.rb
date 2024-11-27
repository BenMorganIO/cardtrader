module Api
  class Client
    BASE_URL = 'https://api.cardtrader.com/api/v2/'
    TOKEN = ENV['CARDTRADER_TOKEN']
    DEFAULT_HEADERS = {
      'Authorization' => "Bearer #{TOKEN}"
    }

    class << self
      def get(path, query = {})
        uri = URI("#{BASE_URL}#{path}")
        uri.query = URI.encode_www_form(query) if query.any?

        response = Net::HTTP.get_response(uri, DEFAULT_HEADERS)
        JSON.parse(response.body, object_class:)
      end

      protected

      def object_class = Hash
    end
  end
end
