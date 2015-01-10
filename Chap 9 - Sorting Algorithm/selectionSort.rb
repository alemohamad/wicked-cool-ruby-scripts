require 'benchmark'

#Selection sort in Ruby
def selection_sort(a)
  a.each_index do |i|
    min_index = min(a, i)
    
    a[i], a[min_index] = a[min_index], a[i]
    
  end
  a
end

def min(subset, from)
  min_value = subset[from..-1].min
  min_index = subset[from..-1].index(min_value) + from
  return min_index
end

#Harness for number to sort, presume 1000 random numbers in a text file
big_array = Array.new
big_array_sorted = Array.new
IO.foreach("1000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i }

#Output time to sort, call Benchmark to time sort, actually sort the numbers
puts Benchmark.measure {big_array_sorted = selection_sort(big_array)}

File.open("output_selection_sort.txt","w") do |out|
  out.puts big_array_sorted
end