require 'benchmark'

#Heap sort in Ruby
def heap_sort(a)
  size = a.length
  i = (size/2)-1

  while i >= 0
    sift_down(a,i,size)
    i-=1
  end

  i=size-1
  while i >= 1
    a[0], a[1] = a[1], a[0]
    sift_down(a, 0, i-1)
    i-=1
  end
  return a
end

def sift_down(num, root, bottom)
  done = false
  max_child = 0

  while root*2 <= bottom and !done
    if root*2 == bottom
      max_child = root * 2
    elsif num[root*2].to_i > num[root*2+1].to_i
      max_child = root * 2
    else
      max_child = root * 2 + 1
    end

    if num[root] < num[max_child]
      num[root], num[max_child] = num[max_child], num[root]
      root = max_child
    else
      done = true
    end
  end
end

#Harness for number to sort, presume 1000 random numbers in a text file
big_array = Array.new
big_array_sorted = Array.new
IO.foreach("1000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i }

#Output time to sort, call Benchmark to time sort, actually sort the numbers
puts Benchmark.measure {big_array_sorted = heap_sort(big_array)}

File.open("output_heap_sort.txt","w") do |out|
  out.puts big_array_sorted
end