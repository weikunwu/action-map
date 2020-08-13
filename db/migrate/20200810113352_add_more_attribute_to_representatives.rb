# frozen_string_literal: true

class AddMoreAttributeToRepresentatives < ActiveRecord::Migration[5.2]
    def change
        add_column :representatives, :address_line1, :string
        add_column :representatives, :address_line2, :string
        add_column :representatives, :address_line3, :string
        add_column :representatives, :city, :string
        add_column :representatives, :state, :string
        add_column :representatives, :zip, :string
        add_column :representatives, :party, :string
        add_column :representatives, :photourl, :string
    end
end
