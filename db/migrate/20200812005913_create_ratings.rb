class CreateRatings < ActiveRecord::Migration[5.2]
    
    def up
        create_table :ratings do |t|
            t.integer :score
            t.belongs_to :user, null: false, index: true
            t.belongs_to :news_item, null: false, index: true
            t.timestamps null: false
        end
    end

    def down
        drop_table :ratings
    end
    
    
    
end
