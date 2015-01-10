require 'benchmark'

#Bubble sort in Ruby
def bubble_sort(a)
  i = 0
  while i<a.size
    j = a.size - 1
    while (i < j)
      if a[j] < a[j - 1]
        a[j], a[j-1] = a[j-1], a[j]
      end
      j-=1
    end
    i+=1
  end
  return a
end

#Harness for number to sort, presume 1000 random numbers in a text file
big_array = Array.new
big_array_sorted = Array.new
IO.foreach("1000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i }

#Output time to sort, call Benchmark to time sort, actually sort the numbers
puts Benchmark.measure {big_array_sorted = bubble_sort(big_array)}

File.open("output_bubble_sort.txt","w") do |out|
  out.puts big_array_sorted
end