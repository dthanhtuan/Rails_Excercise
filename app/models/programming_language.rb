class ProgrammingLanguage < ApplicationRecord
  has_many :developer_programming_languages, dependent: :destroy
  has_many :developers, through: :developer_programming_languages, inverse_of: :programming_languages

  validates :name, presence: true, uniqueness: true
end
