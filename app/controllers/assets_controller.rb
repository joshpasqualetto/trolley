class AssetsController < ApplicationController
  before_filter :find_asset, :except => [ :index, :search, :new, :create ]
  before_filter :format_tag_list, :only => [ :create, :update ]

  respond_to :html, :json

  def index
    @assets = Asset.order("created_at DESC").paginate(:per_page => 50, :page => params[:page])
    respond_with(@assets, :include => :tags, :except => :file)
  end

  def search
    # search Asset.search { fulltext 'exhaust'}.results
    @assets = Asset.search { keywords(params[:q]) }.results
    respond_with(@assets, :include => :tags, :except => :file)
  end

  def show
    @asset = Asset.find(params[:id])
  end

  def download
    send_file(@asset.file.path)
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      redirect_to(@asset, :notice => "Asset creation successful")
    else
      render(:new)
    end
  end

  def edit
  end

  def update
    if @asset.update_attributes(params[:asset])
      redirect_to(@asset, :notice => "Asset successfully updated")
    else
      render(:edit)
    end
  end

  def destroy
    @asset.destroy
    redirect_to(assets_path, :notice => "Asset successfully deleted")
  end

private

  def find_asset
    @asset = Asset.find(params[:id])
  end

  def format_tag_list
    if params[:asset][:tag_list]
      params[:asset][:tag_list] = params[:asset][:tag_list].join(",")
    end
  end
end
