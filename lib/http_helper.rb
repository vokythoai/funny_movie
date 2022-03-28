# frozen_string_literal: true

module HttpHelper
  OPEN_TIMEOUT = 120
  READ_TIMEOUT = 120

  def make_request(method:, path:, params: {}, headers: {})
    query = query_params(params, method)
    url = "#{path}#{query}"
    uri = URI(url)
    http = setup_http_request(uri)
    request = method_request(method, uri, params)

    headers.each do |k, v|
      request[k] = v
    end

    http.request(request)
  end

  private

  def query_params(params, method)
    params.any? && method == :get ? "?#{params.to_query}" : ''
  end

  def setup_http_request(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = OPEN_TIMEOUT
    http.read_timeout = READ_TIMEOUT
    http.use_ssl = true
    http
  end

  def method_request(method, uri, params)
    request = nil
    case method
    when :get
      request = Net::HTTP::Get.new(uri.request_uri)
    when :post
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = params
    when :delete
      request = Net::HTTP::Delete.new(uri.request_uri)
    when :put
      request = Net::HTTP::Put.new(uri.request_uri)
    else
      raise 'Unsupport Method'
    end
    request
  end
end
