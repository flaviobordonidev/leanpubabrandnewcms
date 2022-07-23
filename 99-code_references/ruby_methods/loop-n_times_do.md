# Looping Methods

~~~~~~~~
5.times { puts "i" }

i
i
i
i
i
~~~~~~~~

~~~~~~~~
5.times do 
  puts "i"
end

i
i
i
i
i
~~~~~~~~

~~~~~~~~
5.times { |i| puts i }

0
1
2
3
4
~~~~~~~~

~~~~~~~~
5.times do |i| 
  puts i
end

0
1
2
3
4
~~~~~~~~

