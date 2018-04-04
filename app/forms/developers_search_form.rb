class DevelopersSearchForm
  include Virtus.model
  include ActiveModel::Model
  include ActiveRecord::Sanitization::ClassMethods

  attribute :email, String
  attribute :prog_lang, String
  attribute :language_code, String
  attribute :show_all, Boolean

  def search
    if show_all
      query = Developer.includes(:programming_languages, :languages)
    elsif !email.present? && !prog_lang.present? && !language_code.present?
      Developer.none
    else
      query = Developer.includes(:programming_languages, :languages, :developer_programming_languages, :developer_languages)
      query = query.where('developers.email like :search_string', search_string: "%#{sanitize_sql_like(email)}%") if email.present?
      query = query.where(languages: {code: language_code}) if language_code.present?
      query = query.where(programming_languages: {name: prog_lang}) if prog_lang.present?
      query = query.order('developers.created_at desc')
    end
  end
end