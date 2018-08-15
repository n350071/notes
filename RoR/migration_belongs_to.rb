class CreateSomethings < ActiveRecord::Migration
  def self.up
    create_table :somethings do |t|
      t.belongs_to :parents, foreign_key: true, null: false
      t.string     :title
      t.string     :description

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :somethings
  end
end

class CreateSomethings < ActiveRecord::Migration
  def change
    create_table :somethings do |t|
      t.belongs_to  :parents, foreign_key: true, null: false
      t.string     :title
      t.string     :description

      t.timestamps null: false
    end
  end
end
