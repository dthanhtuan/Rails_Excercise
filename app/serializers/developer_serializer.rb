class DeveloperSerializer < ActiveModel::Serializer
    attributes :id, :email, :languages, :programming_languages
    has_many :languages, serializer: LanguageSerializer
    has_many :programming_languages, serializer: ProgrammingLanguageSerializer
end