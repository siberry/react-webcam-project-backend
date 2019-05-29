class DropSearchTermsTable < ActiveRecord::Migration[5.2]
  def up
   drop_table :search_terms
 end
 def down
   raise ActiveRecord::IrreversibleMigration
 end
end
