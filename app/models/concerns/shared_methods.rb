module SharedMethods
  extend ActiveSupport::Concern

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
  end
  module ClassMethods
    def sort_by_number_of_dependants arr, child_class
      sorted = arr.sort_by do |x| 
      x.send(child_class).size
      end
    end
    def popular current_user, child_class
      arr = self.where(user_id: current_user.id)
      sort_by_number_of_dependants(arr, child_class).reverse
    end
    
    def shuffle_hash hashy
      Hash[hashy.to_a.sample(hashy.length)]
    end
  end

  class ::Array
    def sort_by_number_of child_class
      sorted = self.sort_by do |x|
        x.send(child_class).size
      end
    end
  end
end