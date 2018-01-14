class ImagesService
  def self.create
    success = true
    status = :created
    response = nil

    begin
      destroy_all_images
      generate_images
      response = build_images
    rescue Exception => error
      success = false
      status = :unprocessable_entity
      response = object_error('Erro ocorrido ao gerar imagens. Tente novamente mais tarde.')
    end

    ResultResponseService.new(success, status, response)
  end

  def self.object_error(error)
    image = Image.new
    image.errors.add(:base, error)
    image
  end

  def self.build_images
    images = []

    10.times do |index|
      images.push(create_image_record(index))
    end

    images
  end

  def self.destroy_all_images
    Image.destroy_all
  end

  def self.generate_images
    url_images = get_url_images
    url_images.each_with_index do |image_url, index|
      generate_image(image_url, index)
    end
  end

  def self.get_url_images
    response = HTTParty.get(Settings.url.images)
    url_images = response.parsed_response['images']
    url_images
  end

  def self.create_image_record(index)
    dir = Rails.root.join('public', 'images', "Imagem #{index+1}.jpg")
    file = File.new(dir, 'r')
    Image.create(description: "Imagem #{index+1}.jpg", content: file)
  end
  private_class_method :create_image_record

  def self.generate_image(image_url, index)
    dir = Rails.root.join('public', 'images', "Imagem #{index+1}.jpg")
    file = File.new(dir, 'w')
    file.binmode
    file.write(open(image_url['url']).read)
    file.rewind
    file.close
  end
  private_class_method :generate_image
end
