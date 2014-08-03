require 'spec_helper'
require './lib/routes/mapper'

describe Todo::Routes::Mapper do
  describe '#get' do
    context 'when simple' do
      Given(:mapper) { Todo::Routes::Mapper.new '/users' }
      
      When { mapper.get }
      
      Then { mapper.routes[0][:namespace] == '/users' }
      And { mapper.routes[0][:method] == :get }
      And { mapper.routes[0][:block] == nil }
      And { mapper.routes[0][:name] == 'users' }
      And { mapper.routes[0][:path] == '' }
      And { mapper.routes[0][:view] == 'users/get' }
      And { mapper.routes[0][:on] == :collection }
      And { mapper.routes[0][:fullpath] == '/users' }
    end
    
    context 'when slashes in namespace' do
      Given(:mapper) { Todo::Routes::Mapper.new '/admin/users' }
      
      When { mapper.get }
      
      Then { mapper.routes[0][:namespace] == '/admin/users' }
      And { mapper.routes[0][:method] == :get }
      And { mapper.routes[0][:block] == nil }
      And { mapper.routes[0][:name] == 'admin_users' }
      And { mapper.routes[0][:path] == '' }
      And { mapper.routes[0][:view] == 'admin/users/get' }
      And { mapper.routes[0][:on] == :collection }
      And { mapper.routes[0][:fullpath] == '/admin/users' }
    end
    
    context 'when singular' do
      Given(:mapper) { Todo::Routes::Mapper.new '/admin/users' }
      
      When { mapper.get on: :member }
      
      Then { mapper.routes[0][:namespace] == '/admin/users' }
      And { mapper.routes[0][:method] == :get }
      And { mapper.routes[0][:block] == nil }
      And { mapper.routes[0][:name] == 'admin_user' }
      And { mapper.routes[0][:path] == '/:id' }
      And { mapper.routes[0][:view] == 'admin/user/get' }
      And { mapper.routes[0][:on] == :member }
      And { mapper.routes[0][:fullpath] == '/admin/users/:id' }
    end
    
    context 'when name' do
      Given(:mapper) { Todo::Routes::Mapper.new '/users' }
      
      When { mapper.get 'new' }
      
      Then { mapper.routes[0][:namespace] == '/users' }
      And { mapper.routes[0][:method] == :get }
      And { mapper.routes[0][:block] == nil }
      And { mapper.routes[0][:name] == 'new_users' }
      And { mapper.routes[0][:path] == '/new' }
      And { mapper.routes[0][:view] == 'users/new' }
      And { mapper.routes[0][:on] == :collection }
      And { mapper.routes[0][:fullpath] == '/users/new' }
    end
    
    context 'when path' do
      Given(:mapper) { Todo::Routes::Mapper.new '/users' }
      
      When { mapper.get 'new', '/brand_new' }
      
      Then { mapper.routes[0][:namespace] == '/users' }
      And { mapper.routes[0][:method] == :get }
      And { mapper.routes[0][:block] == nil }
      And { mapper.routes[0][:name] == 'new_users' }
      And { mapper.routes[0][:path] == '/brand_new' }
      And { mapper.routes[0][:view] == 'users/new' }
      And { mapper.routes[0][:on] == :collection }
      And { mapper.routes[0][:fullpath] == '/users/brand_new' }
    end
    
    context 'when path without slash' do
      Given(:mapper) { Todo::Routes::Mapper.new '/users' }
      
      When { mapper.get 'new', 'brand_new' }
      
      Then { mapper.routes[0][:namespace] == '/users' }
      And { mapper.routes[0][:method] == :get }
      And { mapper.routes[0][:block] == nil }
      And { mapper.routes[0][:name] == 'new_users' }
      And { mapper.routes[0][:path] == '/brand_new' }
      And { mapper.routes[0][:view] == 'users/new' }
      And { mapper.routes[0][:on] == :collection }
      And { mapper.routes[0][:fullpath] == '/users/brand_new' }
    end
    
    context 'when multiple' do
      Given(:mapper) { Todo::Routes::Mapper.new '/users' }
      
      When do
        mapper.get
        mapper.get
      end
      
      Then { mapper.routes.length == 2 }
    end
  end
  
  describe '#member' do
    Given(:mapper) { Todo::Routes::Mapper.new '/users' }
    
    When { mapper.member { mapper.get }}
    
    Then { mapper.routes[0][:namespace] == '/users' }
    And { mapper.routes[0][:method] == :get }
    And { mapper.routes[0][:block] == nil }
    And { mapper.routes[0][:name] == 'user' }
    And { mapper.routes[0][:path] == '/:id' }
    And { mapper.routes[0][:view] == 'user/get' }
    And { mapper.routes[0][:on] == :member }
    And { mapper.routes[0][:fullpath] == '/users/:id' }
    
    context 'when continuing' do
      When { mapper.get }
      
      Then { mapper.routes[1][:namespace] == '/users' }
      And { mapper.routes[1][:method] == :get }
      And { mapper.routes[1][:block] == nil }
      And { mapper.routes[1][:name] == 'users' }
      And { mapper.routes[1][:path] == '' }
      And { mapper.routes[1][:view] == 'users/get' }
      And { mapper.routes[1][:on] == :collection }
      And { mapper.routes[1][:fullpath] == '/users' }
    end
  end
  
  describe '#root' do
    Given(:mapper) { Todo::Routes::Mapper.new '/users' }
    
    context 'without name' do
      When { mapper.root }
      
      Then { mapper.routes[0][:namespace] == '/' }
      And { mapper.routes[0][:method] == :get }
      And { mapper.routes[0][:block] == nil }
      And { mapper.routes[0][:name] == 'root' }
      And { mapper.routes[0][:path] == '' }
      And { mapper.routes[0][:view] == 'users/get' }
      And { mapper.routes[0][:on] == :collection }
      And { mapper.routes[0][:fullpath] == '/' }
    end
    
    context 'with name' do
      When { mapper.root 'new' }
      
      Then { mapper.routes[0][:namespace] == '/' }
      And { mapper.routes[0][:method] == :get }
      And { mapper.routes[0][:block] == nil }
      And { mapper.routes[0][:name] == 'root' }
      And { mapper.routes[0][:path] == '' }
      And { mapper.routes[0][:view] == 'users/new' }
      And { mapper.routes[0][:on] == :collection }
      And { mapper.routes[0][:fullpath] == '/' }
    end
  end
end
