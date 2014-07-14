class Item
  attr_accessor :text
  
  def initialize args = {}
    args.each do |k, v|
      m = "#{k}="
      send m, v if respond_to? m
    end
  end
end
