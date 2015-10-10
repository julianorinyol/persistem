module SharedMethods
  def get_num_of_dependants_for_array arr, child_class
    num_of_dependants = []
    arr.each do |x|
      num_of_dependants << x.send(child_class).size
    end
    num_of_dependants.sort
  end
  def sort_by_number_of_dependants arr, child_class
    sorted = arr.sort_by do |x| 
      x.send(child_class).size
    end
    sorted
  end
end