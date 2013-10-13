class Avatar
  include Mongoid::Document
  include Mongoid::Paperclip

  embedded_in :user

  field :name
  field :extension
  has_mongoid_attached_file :image,
                            :path => ':rails_root/public/system/uploads/users/:user/:name:extension',
                            :url => '/system/uploads/users/:user/:name:extension'
end