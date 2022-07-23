foo = "1Aheppsdf"

what = case foo
when /^[0-9]/
  "Begins with a number"
when /^[a-zA-Z]/
  "Begins with a letter"
else
  "Begins with something else"
end
puts "String: #{what}"