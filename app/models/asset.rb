class Asset < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name

  attr_accessible :name, :description, :tag_list, :file

  acts_as_taggable
  has_attached_file :file,
    :url => "/assets/:id_partition/:style_:basename.:extension",
    :path => ":rails_root/public/assets/:id_partition/:style_:basename.:extension",
    :styles => { :medium => "400x300#", :thumb => "200x150#" }

  before_post_process :check_file_type_for_processing

  searchable do
    integer :id
    text :name
    text :tags do
      tags.map { |tag| tag.name }
    end
  end

  def to_param
    "#{id}-#{name.downcase.parameterize}"
  end

  def related(tags)
    Asset.search {
      keywords(tags)
      without(:id).any_of([ self.id ])
    }.results
  end

private

  def check_file_type_for_processing
    file.content_type.include?("image")
  end
end
