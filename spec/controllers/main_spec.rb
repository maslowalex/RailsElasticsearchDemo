require 'rails_helper'

RSpec.describe MainController, type: :controller do
  describe 'search', elasticsearch: true do
    context 'when there is no characters in DB' do
      it 'returns empty array' do
        get :search, params: {q: 'mor'}

        json = JSON.parse(response.body)
        expect(json.fetch('characters')).to eq nil
      end
    end

    context 'when there is characters in DB' do
      let!(:morties) { 5.times { |counter| Character.create(name: "Morty #{counter + 1}", origin: "Earth #{131 + counter}", gender: 'male') } }
      let!(:rick) { Character.create(name: 'Rich Sanches', origin: 'Earth', gender: 'male') }
      let!(:wait_for_indexes_to_refresh) { sleep 1 }

      before do
        get :search, params: {q: 'mo'}
      end

      it 'autocompletes its names' do
        json_resp = JSON.parse(response.body)

        expect(json_resp.dig('characters').size).to eq 5
        expect(Character.count).to eq 6
      end
    end
  end
end
