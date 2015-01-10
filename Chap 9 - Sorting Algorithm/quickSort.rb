require 'benchmark'

#Quick sort in Ruby
def quick_sort(f, a)
  return [] if a.empty?
  pivot  = a[0]
  before = quick_sort(f, a[1..-1].delete_if { |x| not f.call(x, pivot) })
  after  = quick_sort(f, a[1..-1].delete_if { |x| f.call(x, pivot) })
  return (before << pivot).concat(after)
end

#Harness for number to sort, presume 1000 random numbers in a text file
big_array = Array.new
big_array_sorted = Array.new
f = File.open("1000RanNum.txt", "r") or die "Unable to open file..."
IO.foreach("1000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i}

#Output time to sort, call Benchmark to time sort, actually sort the numbers
puts Benchmark.measure {big_array_sorted = quick_sort(Proc.new { |x, pivot| x < pivot }, big_array)}

File.open("output_quick_sort.txt","w") do |out|
  out.puts big_array_sorted
end