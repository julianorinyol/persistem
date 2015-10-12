
  # def sort_by_number_of_dependants arr, child_class
  #   sorted = arr.sort_by do |x| 
  #     x.send(child_class).size
  #   end
  # end
  def full_screen
    this_path = current_path
    page.driver.browser.manage.window.resize_to(1366, 768)
    visit this_path
  end