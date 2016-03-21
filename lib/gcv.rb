class Gcv
  #attr_accessor :endpoint_uri, :file_path

  # def initialize(file_path)
  #   @endpoint_uri = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['SERVER_KEY']}"
  #   @file_path = file_path
  # end

  def request(file_path)
    endpoint_uri = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['SERVER_KEY']}"
    http_client = HTTPClient.new
    content = Base64.strict_encode64(File.new(file_path).read)
    response = http_client.post_content(endpoint_uri, request_json(content), 'Content-Type' => 'application/json')
    unless JSON.parse(response)['responses'].first['textAnnotations'].nil?
      return JSON.parse(response)['responses'].first['textAnnotations'].first['description'].split(' ')
    else
      return nil
    end
    #result_parse(response)
  end

  private

  def request_json(content)
    {
      requests: [{
        image: {
          content: content
        },
        features: [{
          type: "TEXT_DETECTION",
          maxResults: 10
        }]
      }]
    }.to_json
  end

  #def result_parse(response)
    #result = JSON.parse(response)['responses'].first

      #text = result['textAnnotations'].first
      #result = "これは、#{text['locale']}です。\n-----\n#{text['description']}"
#JSON.parse(response)['responses'].first['textAnnotations'].first['description'].split(' ')
    #return JSON.parse(response)['responses'].first['textAnnotations'].first['description'].split(' ')
  #end
end
