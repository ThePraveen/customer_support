class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.references :customer, foreign_key: true
      t.references :executive
      t.references :issue_type, foreign_key: true
      t.string :status
      t.text :title
      t.text :description

      t.timestamps
    end
  end
end
