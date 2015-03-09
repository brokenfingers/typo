When /^The following categories exist/ do |categories_table|
  categories_table.hashes.each do |category|
    added_category = Category.create!(category)
  end
end