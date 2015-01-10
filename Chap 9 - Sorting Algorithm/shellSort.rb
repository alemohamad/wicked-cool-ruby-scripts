require 'benchmark'

#Shell sorting algorithm in Ruby
def shell_sort(a)
  i = 0
  j = 0
  size = a.length
  increment = size / 2
  temp = 0
  
  while increment > 0
    i = increment
    while i<size
      j = i
      temp = a[i]
      while j>=increment and a[j-increment]>temp
        a[j] = a[j-increment]
        j = j-increment
      end
      a[j] = temp
      i+=1
    end
    if increment == 2
      increment = 1
    else
      increment = (increment/2).to_i
    end
  end
  return a
end
  
#Harness for number to sort, presume 1000 random numbers in a text file
big_array = Array.new
big_array_sorted = Array.new
IO.foreach("1000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i }

#Output time to sort, call Benchmark to time sort, actually sort the numbers
puts Benchmark.measure {big_array_sorted = shell_sort(big_array)}

File.open("output_shell_sort.txt","w") do |out|
  out.puts big_array_sorted
end