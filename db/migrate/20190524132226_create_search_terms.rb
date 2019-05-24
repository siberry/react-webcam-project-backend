class CreateSearchTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :search_terms do |t|
      t.string :search_term
      t.string :link_term
      t.string :term_type

      t.timestamps
    end
  end
end
