class User
  include Mongoid::Document
  field :id, type: BSON::ObjectId
  field :username, type: String
  field :email, type: String
  field :pwd1, type:String 
  field :pwd2, type:String
end
