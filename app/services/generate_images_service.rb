class GenerateImagesService
  def self.execute
    url_images = ExternalRequestsService.get_url_images
    url_images.each_with_index do |image_url, index|
      generate_image(image_url, index)
    end
  end

  def self.generate_image(image_url, index)
    file_path = Rails.root.join('public', 'images', "Imagem #{index+1}.jpg")
    file = File.new(file_path, 'w')
    file.binmode
    file.write(ExternalRequestsService.open_url(image_url['url']).read)
    file.rewind
    file.close
  end
  private_class_method :generate_image
end
