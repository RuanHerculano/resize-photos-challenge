class ExternalRequestsService
  def self.get_url_images
    response = HTTParty.get(Settings.url.images)
    response.parsed_response['images']
  end

  def self.open_url(url)
    open(url)
  end
end
