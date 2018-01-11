class ImagesService
  def self.create(image_params)
    response = HTTParty.get('http://54.152.221.29/images.json')
    url_images = response.parsed_response['images']
    url_images.each do |image_url|
      file = File.new(Rails.root.join('public', 'images', image_url['url'].split('/')[4]), 'w')
      file.binmode
      file.write(open(image_url['url']).read)
      file.rewind
      file.close
    end
  end
end
