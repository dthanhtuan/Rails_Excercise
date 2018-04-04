namespace :dev do
  require 'factory_bot_rails'
  require 'faker'

  desc 'Generate test data'
  task generate_data: :environment do

    100.times do
      email = Faker::Internet.email
      Developer.find_or_create_by(email: email)
    end

    language_code_array = %w[en fr cn jp vn]
    Developer.all.each do |developer|
      programming_language = ProgrammingLanguage.find_or_create_by(name: Faker::ProgrammingLanguage.name)
      DeveloperProgrammingLanguage.find_or_create_by(developer_id: developer.id, programming_language_id: programming_language.id)
      language_array = language_code_array.sample(rand(1..5))
      language_array.each do |lang|
        language = Language.find_or_create_by(code: lang)
        DeveloperLanguage.find_or_create_by(developer_id: developer.id, language_id: language.id)
      end
    end

    create_test_user

  end

  def create_test_user
    developer = Developer.find_or_create_by(email: 'tuan.dao@tech.reapra.sg')
    language = Language.find_or_create_by(code: 'en')
    programming_language = ProgrammingLanguage.find_or_create_by(name: 'Ruby')
    DeveloperProgrammingLanguage.find_or_create_by(developer_id: developer.id, programming_language_id: programming_language.id)
    DeveloperLanguage.find_or_create_by(developer_id: developer.id, language_id: language.id)
  end

end

