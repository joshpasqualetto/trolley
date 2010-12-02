class Asset < ActiveRecord::Base
  validates_presence_of :name, :owner

  attr_accessible :name, :owner

  acts_as_taggable
  mount_uploader :file, AssetUploader

  searchable do
    text :name, :owner
    text :tags do
      tags.map { |tag| tag.name }
    end
  end
end
