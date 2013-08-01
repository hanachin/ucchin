placeholder :jpy do
  match /([1-9][0-9,]*)円?/ do |jpy|
    jpy.gsub(/[^0-9]/, '').to_i
  end
end
