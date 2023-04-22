class Friendship
  include Mongoid::Document
  field :_id, type: BSON::ObjectId
  field :userA, type: String
  field :userB, type: String
  field :state, type: Boolean
  include Mongoid::Timestamps
end
