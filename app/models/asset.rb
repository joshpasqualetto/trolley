class Asset < ActiveRecord::Base
  validates_presence_of :name

  attr_accessible :name, :owner, :tag_list, :file, :file_cache

  acts_as_taggable
  mount_uploader :file, AssetUploader

  searchable do
    text :name, :owner
    text :tags do
      tags.map { |tag| tag.name }
    end
  end

  def to_param
    "#{id}-#{name.downcase.parameterize}"
  end
end
