require 'benchmark'

#Merge sort in Ruby
def merge(a1, a2)
  ret = []

  while (true)
    if a1.empty?
      return ret.concat(a2)
    end
    if a2.empty?
      return ret.concat(a1)
    end

    if a1[0] < a2[0]
      ret << a1[0]
      a1 = a1[1...a1.size]
    else
      ret << a2[0]
      a2 = a2[1...a2.size]
    end
  end
end

def merge_sort(a)
  if a.size == 1
    return a
  elsif a.size == 2
    if a[0] > a[1]
      a[0], a[1] = a[1], a[0]
    end
    return a
  end

  size1 = (a.size / 2).to_i
  size2 = a.size - size1

  a1 = a[0...size1]
  a2 = a[size1...a.size]

  a1 = merge_sort(a1)
  a2 = merge_sort(a2)

  return merge(a1, a2)
end

#Harness for number to sort, presume 1000 random numbers in a text file
big_array = Array.new
big_array_sorted = Array.new
IO.foreach("1000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i }

#Output time to sort, call Benchmark to time sort, actually sort the numbers
puts Benchmark.measure {big_array_sorted = merge_sort(big_array)}

File.open("output_merge_sort.txt","w") do |out|
  out.puts big_array_sorted
end