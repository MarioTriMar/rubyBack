class Collection
  include Mongoid::Document
  field :_id, type: BSON::ObjectId
  field :name, type: String
  field :idUser, type: String
  field :notes, type: Array, default:[]
  include Mongoid::Timestamps
end
