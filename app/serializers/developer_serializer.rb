class DeveloperSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :languages
  has_many :programming_languages
end
