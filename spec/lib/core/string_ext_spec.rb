require 'spec_helper'
require './lib/core/string_ext'

describe String do
  describe '#trim' do
    context 'when single character' do
      When(:result) { str.trim '_' }
      
      context 'when leading' do
        Given(:str) { '_foo' }
        Then { result == 'foo' }
      end
      
      context 'when trailing' do
        Given(:str) { 'foo_' }
        Then { result == 'foo' }
      end
      
      context 'when trailing and leading' do
        Given(:str) { '_foo_' }
        Then { result == 'foo' }
      end
      
      context 'when none' do
        Given(:str) { 'foo' }
        Then { result == 'foo' }
      end
      
      context 'when multiple' do
        Given(:str) { '_foo__' }
        Then { result == 'foo' }
      end
    end
    
    context 'when multicharacter' do
      Given(:str) { '_foo__' }
      When(:result) { str.trim '__' }
      Then { result == '_foo' }
    end
    
    context 'when regex' do
      Given(:str) { 'foo' }
      When(:result) { str.trim(/[aeiou]/) }
      Then { result == 'f' }
    end
  end
end
