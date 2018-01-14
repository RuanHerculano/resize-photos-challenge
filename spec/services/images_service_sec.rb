require 'rails_helper'

RSpec.describe ImagesService do
  describe '#destroy_all_images' do
    context 'when destroy all image records' do
      let!(:image) { Image.create(description: '') }

      subject { ImagesService.destroy_all_images }

      before do
        subject
      end

      it 'has none image record' do
        expect(Image.count).to eq 0
      end
    end
  end

  describe '#generate_images' do
    context 'when generate all images from urls' do
      let(:dir) { Rails.root.join('public', 'images') }
      let (:amount_files) do
        Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
      end

      subject { ImagesService.generate_images }

      before do
        subject
      end

      it 'has ten images generated' do
        expect(amount_files).to eq 10
      end
    end
  end

  describe '#get_url_images' do
    context 'when get all urls' do
      subject { ImagesService.get_url_images }

      it 'has arrray with urls' do
        expect(subject.count).to eq 10
      end
    end
  end

  describe '#build_images' do
    context 'when create record of images' do
      subject { ImagesService.build_images }

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
      let(:error) do
        'Erro ocorrido ao gerar imagens. Tente novamente mais tarde.'
      end

      subject { ImagesService.object_error(error) }

      it 'has arrray of images' do
        expect(subject.errors.messages[:base]).to eq [error]
      end
    end
  end

  describe '#create' do
    context 'when create all images record' do
      subject { ImagesService.create }

      it 'has success equal true' do
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
