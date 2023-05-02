class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :_id, type: BSON::ObjectId
  field :username, type: String
  field :email, type: String
  field :phone, type: String
  field :image, type: String
  field :type, type: String
  field :password_digest, type:String 
  

  validates :email, uniqueness: true
  validates :username, uniqueness: true
  
  has_secure_password
end
