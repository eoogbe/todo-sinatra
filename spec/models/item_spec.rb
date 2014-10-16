require 'app_helper'
require './app/models/item'

describe Item do
  describe '#validate' do
    Given(:item) { new_item }
    
    When(:valid) { item.validate }
    
    context 'when valid' do
      Then { !!valid }
    end
    
    context 'when text blank' do
      Given { item.text = '' }
      
      Then { !valid }
      And { item.errors[:text].include? :blank }
    end
    
    context 'when user blank' do
      Given { item.user = nil }
      
      Then { !valid }
      And { item.errors[:user].include? :blank }
    end
  end
end
