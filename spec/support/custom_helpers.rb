module CustomHelpers
  def get_num_of_dependants_for_all parent_class, child_class
    get_num_of_dependants_for_array(Object.const_get(parent_class).all, child_class).sort
  end

  def get_num_of_dependants_for_array arr, child_class
    num_of_dependants = []
    arr.each do |x|
      num_of_dependants << x.send(child_class).size
    end
    num_of_dependants.sort
  end

  def create_x_many_objects(num, factory)
    num.to_i.times do
      create(factory.to_sym)
    end
  end
end