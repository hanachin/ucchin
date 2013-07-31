placeholder :jpy do
  match /([1-9][0-9,]*)円?/ do |jpy|
    jpy.gsub(',', '').to_i
  end
end
