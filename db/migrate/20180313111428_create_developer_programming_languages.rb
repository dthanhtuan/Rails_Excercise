class CreateDeveloperProgrammingLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :developer_programming_languages do |t|
      t.references :developer, foreign_key: true , index: { name: 'dev_dev_pro_lang' }
      t.references :programming_language, foreign_key: true,index: { name: 'pro_lang_dev_pro_lang' }
      t.timestamps
    end
    add_index(:developer_programming_languages, [:developer_id, :programming_language_id], unique: true, null: false, :name => 'index_dev_programing')
  end
end
