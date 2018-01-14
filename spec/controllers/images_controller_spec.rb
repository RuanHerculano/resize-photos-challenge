require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  describe 'GET #index' do
    context 'show all books' do
      let(:image) { Image.create(description: '') }

      before do
        get(:index)
      end

      it 'populates an array of images' do
        expect(assigns(:images)).to eq [image]
      end

      it 'renders the :index view' do
        expect(response.body).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    let(:image) { Image.create(description: '') }

    before do
      get(:show, params: { id: image.id })
    end


    it 'assigns the requested contact to @image' do
      expect(assigns(:image)).to eq image
    end

    it 'renders the #show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET new' do
    before do
      get(:new)
    end

    it 'assigns a new image' do
      expect(assigns(:image)).to be_a(Image)
    end

    it 'renders the new image template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    subject do
      post(:create)
    end

    it 'creates a new book' do
      subject
      expect(Image.count).to eq 10
    end

    it 'redirects to the new contact' do
      expect(subject).to redirect_to images_path
    end
  end
end
