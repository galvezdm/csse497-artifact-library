class PermissionGroup
  include Mongoid::Document
  field :name
  field :universal, type: Boolean, default: false
  has_many :users
  belongs_to :owner, class_name: "User"
end