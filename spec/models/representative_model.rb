# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

describe Representative do
    it 'should be defined' do
        expect(Representative).not_to raise_error
    end

    describe 'has an address' do
        before(:each) do
            @representative = Representative.new(state: 'DC')
        end

        it 'is a hash' do
            expect(@representative.address).to have_key(:state)
        end

        it 'sets state' do
            expect(@representative.state).to eq 'DC'
        end

        it 'can change state' do
            @representative.state = 'CA'
            expect(@representative.state).to eq 'CA'
        end
    end
    describe 'photo URI' do
        it 'has a URI' do
            @representative = Representative.new(photourl: 'image_link')
            expect(@representative.photourl).to eq 'image_link'
        end
    end

    describe 'stores information from civic_api_to_representative_params' do
        before(:each) do
            address = 'Polk County'
            service = Google::Apis::CivicinfoV2::CivicInfoService.new
            service.key = 'AIzaSyCI4oz-tPiN_5ENDt4S3bX2y1LGtQr_J14'
            @rep_info = service.representative_info_by_address(address: address)
            @representatives = Representative.civic_api_to_representative_params(@rep_info)
        end

        it 'sets address state' do
            state = @rep_info.officials[0].address[0].state
            expect(@representatives[0].state).to eq state
        end

        it 'sets photourl' do
            photourl = @rep_info.officials[0].photo_url
            expect(@representatives[0].photourl).to eq photourl
        end
    end

    describe 'find all representatives in the same county' do
        before(:each) do
            address = '91754'
            service = Google::Apis::CivicinfoV2::CivicInfoService.new
            service.key = 'AIzaSyCI4oz-tPiN_5ENDt4S3bX2y1LGtQr_J14'
            @rep_info = service.representative_info_by_address(address: address)
            @representatives = Representative.civic_api_to_representative_params(@rep_info)
        end

        it 'works' do
            reps = Representative.in_same_county('Los Angeles')
            expect(reps.length).to eq 3
        end
    end
end
