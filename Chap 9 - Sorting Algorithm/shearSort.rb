require 'benchmark'

#Shear sort in Ruby
class Shear_sort
  def sort(a)
    div = 1
    i   = 1
      
    while i * i <= a.length
      if a.length % i == 0
        div = i
      end
      i += 1
    end

    @rows = div
    @cols = a.length/div

    @log = Math.log(@rows).to_i

    @log.times do 
      (@cols / 2).times do
        @rows.times do |i|
          part1_sort(a, i*@cols, (i+1)*@cols, 1, i % 2 == 0)
        end

        @rows.times do |i|
          part2_sort(a, i*@cols, (i+1)*@cols, 1, i % 2 == 0)
        end
      end

      (@rows / 2).times do
        @cols.times do |i|
          part1_sort(a, i, @rows*@cols+i, @cols, true)
        end

        @cols.times do |i|
          part2_sort(a, i, @rows*@cols+i, @cols, true)
        end
      end
    end

    (@cols / 2).times do
      @rows.times do |i|
        part1_sort(a, i*@cols, (i+1)*@cols, 1, true)
      end

      @rows.times do |i|
        part2_sort(a, i*@cols, (i+1)*@cols, 1, true)
      end
    end
    return a
  end

  def part1_sort(ap_array, a_low, a_hi, a_nx, a_up)
    part_sort(ap_array, a_low, a_hi, a_nx, a_up)
  end

  def part2_sort(ap_array, a_low, a_hi, a_nx, a_up)
    part_sort(ap_array, a_low + a_nx, a_hi, a_nx, a_up)
  end

  def part_sort(ap_array, j, a_hi, a_nx, a_up)
    while (j + a_nx) < a_hi
      if((a_up && ap_array[j] > ap_array[j+a_nx]) || !a_up && ap_array[j] < ap_array[j+a_nx])
        ap_array[j], ap_array[j + a_nx] = ap_array[j+a_nx], ap_array[j]
      end
      j += a_nx * 2
    end
  end
end

#Harness for number to sort, presume 1000 random numbers in a text file
big_array = Array.new
big_array_sorted = Array.new

IO.foreach("1000RanNum.txt", $\ = ' ') {|num| big_array.push num.to_i }

#Output time to sort, call Benchmark to time sort, actually sort the numbers
puts Benchmark.measure {big_array_sorted = Shear_sort.new.sort(big_array)}

File.open("output_shear_sort.txt","w") do |out|
  out.puts big_array_sorted
end