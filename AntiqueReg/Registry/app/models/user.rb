class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  #Remember tokens for sessions
  before_save :create_remember_token

  #Basic Information
  field :email, :type => String
  field :first_name, type: String
  field :last_name, type: String
  field :phone_number, type: String
  field :address, type: String
  field :city, type: String
  field :state, type: String
  field :postal_code, type: String

  #Profile pic
  embeds_one :avatar

  #Authentication
  validates_presence_of :password, :on => :create
  field :password_digest, :type => String
  has_secure_password

  #Collections & Artifacts
  has_many :artifacts, inverse_of: :owner
  has_many :artifact_collections, inverse_of: :owner
  field :universal

  #Friends
  has_and_belongs_to_many :friends, :class_name => "User", inverse_of: :friends

  #Permission Groups
  belongs_to :permission_group
  has_many :permission_groups, :inverse_of => :owner

  #Validation
  validates_presence_of :email, :phone_number, :address, :city, :state, :postal_code
  validates_uniqueness_of :email
  validates_format_of :email, with: /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  #Sessions
  field :remember_token_expires_at, :type => Time
  field :remember_token, :type => String


  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  public
  def get_visible_collections(searcher_id)
    searcher = User.find(searcher_id)
    if(self.id == searcher_id)
      return self.artifact_collections
    end
    permissions_group = searcher.get_permissions_group(self.id)
    visible = []
    if(permissions_group == nil)
       self.artifact_collections.each do |collection|
         if(collection.universal)
           visible << collection
         end
       end
    else
      self.artifact_collections.each do |collection|
        if(collection.permission_groups.include?(permissions_group) || collection.universal)
          visible << collection
        end
      end
    end
    return visible
  end

  def get_permissions_group(owner_id)
    owner = User.find(owner_id)
    return_group = nil
    owner.permission_groups.each do |group|
      if(group.users.include?(self))
        return_group = group
      end
    end
    return return_group
  end

  #Picture Related
  def add_avatar(picture)
    file_name = self.first_name+'_'+self.last_name
    extension = File.extname(picture.original_filename)
    Avatar.create(:image => picture.tempfile, :name => file_name, :extension => extension, :user => self)
  end

  def delete_avatar
    if !self.avatar.image.nil?
      self.avatar.image.clear
      self.avatar.delete
      self.save
    end
  end

  def update_avatar(picture)
    if !self.avatar.nil? && !self.avatar.image.nil?
      self.delete_avatar
    end
    self.add_avatar(picture)
  end
end
