class AssetsController < ApplicationController
  before_filter :find_asset, :except => [ :index, :new, :create ]

  def index
    # search Asset.search { fulltext 'exhaust'}.results
    @assets = Asset.all
  end

  def show
    @asset = Asset.find(params[:id])
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(params[:asset])
    @asset.tag_list = params[:tags]
    if @asset.save
      redirect_to(@asset, :notice => "Asset creation successful")
    else
      render(:action => "new")
    end
  end

  def edit
  end

  def update
    @asset.tag_list = params[:tags]
    if @asset.update_attributes(params[:asset])
      redirect_to(@asset, :notice => "Asset successfully updated")
    else
      render(:action => "edit")
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
end
