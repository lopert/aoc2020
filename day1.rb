# https://adventofcode.com/2020/day/1

# --- Day 1: Report Repair ---
# Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.

# For example, suppose your expense report contained the following:

# 1721
# 979
# 366
# 299
# 675
# 1456
# In this list, the two entries that sum to 2020 are 1721 and 299. Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.

# Of course, your expense report is much larger. Find the two entries that sum to 2020; what do you get if you multiply them together?

class ExpenseReader

    def initialize(filename)
        @filename = filename
    end

    def solve
        file_data = File.read(@filename).split

        under_one_thousand = []

        file_data.each_with_index do |number, index|
            if number.to_i <= 1000
                under_one_thousand << number
                file_data.slice!(index)
            end
        end

        under_one_thousand.each do |small_string|
            file_data.each do |large_string|
                small_number = small_string.to_i
                large_number = large_string.to_i
                if (small_number. + large_number) == 2020
                    return small_number * large_number # 1009899
                end
            end
        end

        return false

    end

end

solver = ExpenseReader.new("day1input.txt")
puts solver.solve
