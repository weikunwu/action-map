# frozen_string_literal: true

class Representative < ApplicationRecord
    has_many :news_items, dependent: :delete_all

    def address
        { line1: address_line1, line2: address_line2,
         line3: address_line3, city: city,
         state: state, zip: zip }
    end

    class FakeAddress
        def line1
            ''
        end

        def line2
            ''
        end

        def line3
            ''
        end

        def city
            ''
        end

        def state
            ''
        end

        def zip
            ''
        end
    end

    def update_representative_address(address)
        self.address_line1 = address.line1
        self.address_line2 = address.line2
        self.address_line3 = address.line3
        self.city = address.city
        self.state = address.state
        self.zip = address.zip
        save
    end

    def update_representative_party(party)
        self.party = party
        save
    end

    def update_representative_photo_url(photo_url)
        self.photourl = photo_url
        save
    end

    def self.make_new_representative(official, ocdid_temp, title_temp)
        rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
                                           title: title_temp })

        address = if official.address.nil?
                      FakeAddress.new
                  else
                      official.address[0]
                  end

        rep.update_representative_address(address)
        rep.update_representative_party(official.party)
        rep.update_representative_photo_url(official.photo_url)
    end

    def self.add_representative_to_database(official, ocdid_temp, title_temp)
        rep = Representative.where('name=? AND ocdid=? AND title=?', official.name, ocdid_temp, title_temp)[0]
        make_new_representative(official, ocdid_temp, title_temp) if rep.nil?
        rep
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

            rep = add_representative_to_database(official, ocdid_temp, title_temp)
            reps.push(rep)
        end

        reps
    end

    def self.in_same_county(county)
        county.gsub! ' County', ''
        county.gsub! ' ', '_'
        reps = Representative.where('ocdid LIKE ?', "%#{county.downcase}").to_a
    end
end
