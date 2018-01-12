class ImagesService
  def self.create
    success = true
    status = :created
    response = nil

    begin
      destroy_all_images
      generate_images
      response = create_records
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

  def self.create_records
    images = []

    10.times do |index|
      image = Image.new
      image.description = "Imagem #{index+1}.jpg"
      image.content = File.new(Rails.root.join('public', 'images', "Imagem #{index+1}.jpg"), 'r')
      image.save
      images.push(image)
    end

    images
  end

  def self.destroy_all_images
    Image.destroy_all
  end

  def self.generate_images
    response = HTTParty.get('http://54.152.221.29/images.json')
    url_images = response.parsed_response['images']
    url_images.each_with_index do |image_url, index|
      file = File.new(Rails.root.join('public', 'images', "Imagem #{index+1}.jpg"), 'w')
      file.binmode
      file.write(open(image_url['url']).read)
      file.rewind
      file.close
    end
  end
end
