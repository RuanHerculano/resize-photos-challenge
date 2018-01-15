class RecordImagesService
  def self.create
    success = true
    status = :created
    response = nil

    begin
      destroy_all_images
      GenerateImagesService.execute
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
    file_path = Rails.root.join('public', 'images')
    amount_images = Dir[File.join(file_path, '**', '*')].count { |file| File.file?(file) }

    amount_images.times do |index|
      images.push(create_image_record(index))
    end

    images
  end

  def self.destroy_all_images
    Image.destroy_all
  end

  def self.create_image_record(index)
    file_path = Rails.root.join('public', 'images', "Imagem #{index+1}.jpg")
    file = File.new(file_path, 'r')
    Image.create(description: "Imagem #{index+1}.jpg", content: file)
  end
  private_class_method :create_image_record
end
