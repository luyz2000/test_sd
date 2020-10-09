require 'rails_helper'
include Microservicio

RSpec.describe 'Track Numbers', type: :system do

  describe 'Deliver Expected Results' do

    it 'Track status Created' do
      result = Deliver.get('fedex', '449044304137821' )
      expect(result).to eq('CREATED')
    end

    it 'Track status Delivered' do
      result = Deliver.get('fedex', '122816215025810' )
      expect(result).to eq('DELIVERED')
    end

    it 'Track status On Transit' do
      result = Deliver.get('fedex', '231300687629630' )
      expect(result).to eq('ON_TRANSIT')
    end

    it 'Track status On Transit' do
      result = Deliver.get('fedex', '390321684219' )
      expect(result).to eq('EXCEPTION')
    end

  end

end
