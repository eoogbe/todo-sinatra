require 'app_helper'
require './app/models/item'

describe Item do
  describe '#validate' do
    Given(:item) { new_item }
    
    When(:valid) { item.validate }
    
    context 'when valid' do
      Then { valid }
    end
    
    context 'when invalid' do
      Given { item.text = '' }
      
      Then { !valid }
      And { item.errors[:text].include? :blank }
    end
  end
end
