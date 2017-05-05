class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :description
      t.references :podcast, index: true

      t.timestamps null: false
    end
    add_foreign_key :episodes, :podcasts
    add_index :episodes, [:podcast_id, :created_at]
  end
end
