class Object
  def mass_assign args
    args.each do |k, v|
      m = "#{k}="
      send m, v if respond_to? m
    end
  end
end
