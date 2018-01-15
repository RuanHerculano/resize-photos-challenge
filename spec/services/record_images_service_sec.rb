require 'rails_helper'

RSpec.describe RecordImagesService do
  describe '#destroy_all_images' do
    context 'when destroy all image records' do
      let!(:image) { Image.create(description: '') }

      before do
        RecordImagesService.destroy_all_images
      end

      subject { Image.count }

      it 'has none image record' do
        is_expected.to eq 0
      end
    end
  end

  describe '#generate_images' do
    context 'when generate all images from urls' do
      let(:dir) { Rails.root.join('public', 'images') }
      let(:imagens) do
        [
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' }
        ]
      end

      let (:amount_files) do
        Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
      end

      let(:file_path) do
        Rails.root.join('public', 'images', 'Imagem 1.jpg')
      end

      subject { amount_files }

      before do
        allow(ExternalRequestsService).to receive(:get_url_images).and_return imagens
        allow(ExternalRequestsService).to receive(:open_url).and_return File.new(file_path, 'r')

        GenerateImagesService.execute
      end

      it 'has ten images generated' do
        is_expected.to eq 10
      end
    end
  end

  describe '#build_images' do
    context 'when create record of images' do
      let(:imagens) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }

      subject { RecordImagesService.build_images }

      before do
        allow(ExternalRequestsService).to receive(:get_url_images).and_return imagens
      end


      it 'has arrray of images' do
        expect(subject.count).to eq 10
      end

      it 'has model of the record equal Image' do
        expect(subject[0].class).to eq Image
      end
    end
  end

  describe '#object_error' do
    context 'when error occurs while generating image records' do
      let(:imagens) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }

      let(:error_message) do
        'Erro ocorrido ao gerar imagens. Tente novamente mais tarde.'
      end

      let(:object_error) { RecordImagesService.object_error(error_message) }

      before do
        allow(ExternalRequestsService).to receive(:get_url_images).and_return imagens
      end

      subject { object_error.errors.messages[:base] }

      it 'has arrray of images' do
        is_expected.to eq [error_message]
      end
    end
  end

  describe '#create' do
    context 'when create all images record' do
      let(:imagens) do
        [
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' },
          { 'url' => '' }
        ]
      end

      let(:file_path) do
        Rails.root.join('public', 'images', 'Imagem 1.jpg')
      end

      before do
        allow(ExternalRequestsService).to receive(:get_url_images).and_return imagens
        allow(ExternalRequestsService).to receive(:open_url).and_return File.new(file_path, 'r')
      end

      subject { RecordImagesService.create }

      it 'has success equal true' do
        byebug
        expect(subject.success).to eq true
      end

      it 'has status created' do
        expect(subject.status).to eq :created
      end

      it 'has arrray of images' do
        expect(subject.response.count).to eq 10
      end

      it 'has model of the record equal Image' do
        expect(subject.response[0].class).to eq Image
      end
    end
  end
end
