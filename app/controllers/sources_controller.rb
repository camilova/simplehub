class SourcesController < ApplicationController
  before_action :set_item_order, only: [:new, :edit, :create, :update]
  before_action :set_source, only: [:show, :download, :edit, :update, :destroy]

  # GET /sources
  def index
    @sources = Source.all
  end

  # GET /sources/1
  def show
    send_resource
  end

  def download
    if @source.allow_download?
      send_resource :attachment
    else
      head :forbidden
    end
  end

  # GET /sources/new
  def new
    @source = Source.new
    render partial: 'form', callback: 'modal', 
      locals: { item: @item }
  end

  # GET /sources/1/edit
  def edit
    render partial: 'form', callback: 'modal', 
      locals: { item: @item }
  end

  # POST /sources
  def create
    @source = Source.new(source_params)
    if @source.save
      head :ok
    else
      head :internal_server_error
    end
  end

  # PATCH/PUT /sources/1
  def update
    if @source.update(source_params)
      render partial: 'sources/source', callback: 'replace', locals: { source: @source }
    else
      head :internal_server_error
    end
  end

  # DELETE /sources/1
  # DELETE /sources/1.json
  def destroy
    @source.destroy
    respond_to do |format|
      format.html { redirect_to sources_url, notice: 'Source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source
      @source = Source.find(params[:id])
    end

    def set_item_order
      @item = Item.find((params[:source].presence || params)[:item])
    end

    def source_params
      params.require(:source).permit(:title, :link, :uploaded_file, :deprecated, :allow_download)
    end

    def send_resource disposition = :inline
      send_data @source.resource, disposition: disposition, 
        type: @source.mime_type, range: @source.streaming?
    end
end
