class SharedNote
  include Mongoid::Document
  field :_id, type: BSON::ObjectId
  field :userId, type: String
  field :noteId, type: String
  field :state, type: Boolean
end
