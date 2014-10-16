require 'app_helper'
require './app/models/user'

describe User do
  describe '#validate' do
    Given(:user) { new_user }
    
    When(:valid) { user.validate }
    
    context 'when valid' do
      Then { !!valid }
    end
    
    context 'when email blank' do
      Given { user.email = '' }
      
      Then { !valid }
      And { user.errors[:email].include? :blank }
    end
    
    context 'when email not unique' do
      Given { create_user(email: user.email) }
      
      Then { !valid }
      And { user.errors[:email].include? :duplicate }
    end
    
    context 'when email wrong format' do
      Given { user.email = 'invalid' }
      
      Then { !valid }
      And { user.errors[:email].include? :format }
    end
    
    context 'when password blank' do
      Given { user.password = '' }
      
      Then { !valid }
      And { user.errors[:password].include? :blank }
    end
    
    context 'when password shorter than 12 characters' do
      Given { user.password = 'foobar' }
      
      Then { !valid }
      And { user.errors[:password].include? :too_short }
    end
    
    context "when password doesn't match password confirmation" do
      Given { user.password_confirmation = 'foobar' }
      
      Then { !valid }
      And { user.errors[:password].include? :confirmation }
    end
  end
end
