class ImagesController < ApplicationController
  before_action :set_image, only: [:show]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # POST /images
  # POST /images.json
  def create
    result = ImagesService.create

    respond_to do |format|
      if result.success
        format.html { redirect_to images_path, notice: 'Imagens geradas com sucesso.' }
        format.json { render :index, status: result.status, location: images_path }
      else
        format.html { render :new }
        format.json { render json: result.response, status: result.status }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end
end
