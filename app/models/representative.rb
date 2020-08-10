# frozen_string_literal: true

class Representative < ApplicationRecord
    has_many :news_items, dependent: :delete_all
    
    def address
        {:line1=>self.address_line1, :line2=>self.address_line2,
         :line3=>self.address_line3, :city=>self.city,
         :state=>self.state, :zip=>self.zip}
    end
    
    class FakeAddress
        def line1
            return nil
        end
        def line2
            return nil
        end
        def line3
            return nil
        end        
        def city
            return nil
        end        
        def state
            return nil
        end        
        def zip
            return nil
        end
    end
  
    def self.civic_api_to_representative_params(rep_info)
        reps = []
        rep_info.officials.each_with_index do |official, index|
            ocdid_temp = ''
            title_temp = ''

            rep_info.offices.each do |office|
                if office.official_indices.include? index
                    title_temp = office.name
                    ocdid_temp = office.division_id
                end
            end

            rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
                                           title: title_temp })
            
            if official.address.nil?
              address = FakeAddress.new
            else
              address = official.address[0]
            end
          
            rep.address_line1 = address.line1
            rep.address_line2 = address.line2
            rep.address_line3 = address.line3
            rep.city = address.city
            rep.state = address.state
            rep.zip = address.zip
          
            rep.party = official.party
            rep.photourl = official.photo_url
            
            rep.save
            reps.push(rep)
        end

        reps
    end
end
