# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |movie,director|
    assert director.eql?(Movie.find_by_title(movie).director)
end


Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body.match(/.*#{e1}.*#{e2}.*/m) 
end


When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    if 'un'.eql?(uncheck)
        uncheck("ratings_#{rating}")
    else
        check("ratings_#{rating}")
    end
  end
end

Then /I should see all of the movies/ do
  assert page.all("table#movies tr").count == 11 
end

Then /I should see no movies/ do
  assert page.all("table#movies tr").count == 1
end
