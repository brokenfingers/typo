When /^The following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    comment_param = article.delete("comments")
    added_article = Article.create!(article)
    hash = {}
    comment_param.split(',').each do |pair|
      key,value = pair.split(/:/)
      hash[key] = value
    end
    added_article.add_comment(hash.symbolize_keys)
    added_article.save
  end
end

When /^The following users exist/ do |users_table|
  users_table.hashes.each do |user|
    added_user = User.create!(user)
  end
end

When /^(?:|I )fill in "([^"]*)" with the id of article "([^"]*)"$/ do |field, article_title|
  article = Article.find(:first, :conditions => [ "title = ?", article_title])
  fill_in(field, :with => article.id)
end