class Picture
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :artifact, :inverse_of => :pictures

  field :name
  field :extension
  field :is_cover
  field :order_number
  has_mongoid_attached_file :image,
                            :path => ':rails_root/public/system/uploads/artifacts/:artifact/:name:extension',
                            :url => '/system/uploads/artifacts/:artifact/:name:extension'
end