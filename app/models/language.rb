class Language < ApplicationRecord
  has_many :developer_languages, dependent: :destroy
  has_many :developers, through: :developer_languages, inverse_of: :languages

  validates :code, presence: true, uniqueness: true
end
