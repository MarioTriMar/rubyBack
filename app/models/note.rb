class Note
  include Mongoid::Document
  field :_id, type: BSON::ObjectId
  field :title, type: String
  field :text, type: String
  field :tag, type: String
  include Mongoid::Timestamps
end
