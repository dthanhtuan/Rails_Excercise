class DevelopersSearchForm
  include Virtus.model
  include ActiveModel::Model
  include ActiveRecord::Sanitization::ClassMethods

  attribute :email, String
  attribute :prog_lang, String
  attribute :language_code, String
  attribute :show_all, Boolean

  def search
    return Developer.includes(:programming_languages, :languages) if show_all
    return Developer.none if [email, language_code, prog_lang].all?(&:blank?)
    query = Developer.includes(:programming_languages, :languages)
    query = query.where('developers.email like :search_string', search_string: "%#{sanitize_sql_like(email)}%") if email.present?
    query = query.joins(:languages).where(languages: { code: language_code }) if language_code.present?
    query = query.joins(:programming_languages).where(programming_languages: { name: prog_lang }) if prog_lang.present?
    query
  end
end
