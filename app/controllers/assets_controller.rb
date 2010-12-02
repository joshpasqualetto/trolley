class AssetsController < ApplicationController
  def index
    #search Asset.search { fulltext 'exhaust'}.results
    @assets = Asset.all
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(params[:asset])
    @asset.tag_list = params[:tags]
    if @asset.save
      flash[:notice] = "Asset creation successful"
      redirect_to @asset
    else
      render :action => 'new'
    end
  end

  def edit
    @asset = Asset.find(params[:id])
  end
  
  def update
    @asset = Asset.find(params[:id])
    @asset.tag_list = params[:tags]
    if @asset.update_attributes(params[:asset])
      flash[:notice] = "Asset successfully updated"
      redirect_to @asset
    else
      render :action => 'edit'
    end
  end

  def show
    @asset = Asset.find(params[:id])
  end
end
