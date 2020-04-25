class SourcesController < ApplicationController
  before_action :set_item, only: [:new]
  before_action :set_source, only: [:show, :download, :edit, :update, :destroy, :move]
  before_action :authenticate_user!, except: [:index, :download, :show]

  # GET /sources/1
  def show
    send_resource
  end

  # GET /sources/1/download
  def download
    if @source.allow_download?
      send_resource :attachment
    else
      head :forbidden
    end
  end

  # GET /sources/new
  def new
    @source = Source.new(item: @item)
    render partial: 'form', callback: 'modal', 
      locals: { item: @item }
  end

  # GET /sources/1/edit
  def edit
    render partial: 'form', callback: 'modal'
  end

  # POST /sources
  def create
    @source = Source.new(source_params)
    if @source.save
      render partial: 'sources/source', callback: 'prependSource',
        locals: { source: @source, item: @source.item }
    else
      head :internal_server_error
    end
  end

  # PATCH/PUT /sources/1
  def update
    begin
      if @source.update(source_params)
        render partial: 'sources/source', callback: 'replace',
          locals: { source: @source, item: @source.item }
      else
        head :internal_server_error
      end
    rescue StandardError
      render json: t('.attachment_to_big').to_json, callback: 'alert', 
        status: :unprocessable_entity
    end
  end

  # DELETE /sources/1
  def destroy
    if @source.update(deleted: true)
      render json: "source-#{@source.id}".to_json, callback: 'destroy'
    else
      head :internal_server_error
    end
  end

  # POST /items/1/move?direction=up
  def move
    direction = params[:direction]
    case direction
    when 'up'
      @source.move_higher
    when 'down'
      @source.move_lower
    end
    render json: { id: "source-#{@source.id}", direction: direction }, callback: 'move'
  end

  private
    
    def set_source
      @source = Source.find(params[:id])
    end

    def set_item
      @item = Item.find(params[:item])
    end

    def source_params
      params.require(:source).permit(:title, :link, :uploaded_file, :deprecated, :allow_download, :item_id)
    end

    def send_resource disposition = :inline
      attachment = @source.attachment_file
      send_data attachment.resource, filename: attachment.filename, disposition: disposition, 
        type: attachment.mime_type, range: @source.streaming?
    end
end
