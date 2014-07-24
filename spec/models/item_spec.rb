require 'rspec/given'
require 'spec_helper'
require './app/models/item'

describe Item do
  describe '#validate' do
    When(:valid) { item.validate }
    
    context 'when valid' do
      Given(:item) { Item.new text: 'The text' }
      Then { valid }
    end
    
    context 'when invalid' do
      Given(:item) { Item.new }
      Then { !valid }
      And { item.errors[:text].include? :blank }
    end
  end
end
