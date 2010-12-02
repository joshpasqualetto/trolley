class AssetUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version(:thumb) do
    process(:resize_to_fill => [ 100, 100 ])
  end

  version(:medium) do
    process(:resize_to_fill => [ 450, 450 ])
  end

  def relative_dir
    ("%09d" % model.id).scan(/\d{3}/).join("/")
  end

  def store_dir
    File.join(Rails.root, "public", "assets", relative_dir)
  end
end
