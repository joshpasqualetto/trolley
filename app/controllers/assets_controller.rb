class AssetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_asset, :except => [ :index, :search, :new, :create ]
  before_filter :format_tag_list, :only => [ :create, :update ]

  respond_to :html, :json

  def index
    @assets = Asset.order("created_at DESC").paginate(:per_page => 20, :page => params[:page])
    respond_with(@assets, :include => :tags, :except => :file)
  end

  def search
    @assets = Asset.search { 
      keywords(params[:q])
      paginate(:per_page => 20, :page => params[:page])
    }.results
    respond_with(@assets, :include => :tags, :except => :file)
  end

  def show
    @asset = Asset.find(params[:id])
    @related_assets = @asset.related(@asset.tags.join(" "))
  end

  def download
    send_file(@asset.file.path, :filename => @asset.file.original_filename, :type => @asset.file.content_type)
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = current_user.assets.new(params[:asset])
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
