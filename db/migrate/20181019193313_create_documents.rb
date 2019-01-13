class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :document_name
      t.datetime :date_uploaded
      t.string :uploaded_by
      t.integer :size # in bytes

      t.timestamps
    end
  end
end
