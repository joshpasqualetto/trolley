class AssetUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version(:thumb) do
    process(:resize_to_fill => [ 200, 150 ])
  end

  version(:medium) do
    process(:resize_to_fill => [ 400, 300 ])
  end

  def relative_dir
    ("%09d" % model.id).scan(/\d{3}/).join("/")
  end

  def store_dir
    File.join(Rails.root, "public", "assets", relative_dir)
  end
end
