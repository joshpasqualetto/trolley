class Asset < ActiveRecord::Base
  validates_presence_of :name

  attr_accessible :name, :description, :tag_list, :file

  acts_as_taggable
  mount_uploader :file, AssetUploader

  searchable do
    text :name
    text :tags do
      tags.map { |tag| tag.name }
    end
  end

  def to_param
    "#{id}-#{name.downcase.parameterize}"
  end
end
