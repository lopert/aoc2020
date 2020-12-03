# https://adventofcode.com/2020/day/1

class ExpenseReader

    def initialize(filename)
        @filename = filename
    end

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
    def solve_part_one
        file_data = File.read(@filename).split

        # start by splitting the list in "over or under 1k"
        under_one_thousand = []

        file_data.each_with_index do |number, index|
            if number.to_i <= 1000
                under_one_thousand << number
                file_data.slice!(index)
            end
        end

        # n^2, but actually quicker because of the initial split
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

    # --- Part Two ---
    # The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. They offer you a second one if you can find three numbers in your expense report that meet the same criteria.

    # Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.

    # In your expense report, what is the product of the three entries that sum to 2020?
    def solve_part_two

        file_data = File.read(@filename).split

        #shitty attempt with nested loops
        file_data.each_with_index do |str1, index1|

            #remove this number from the array, since we're about to test it against everything
            file_data.slice!(index1)

            file_data.each_with_index do |str2, index2|
                #remove this number from the array, since we're about to test it against all remaining values
                file_data.slice!(index2)

                file_data.each_with_index do |str3, index3|

                    num1 = str1.to_i
                    num2 = str2.to_i
                    num3 = str3.to_i

                    if (num1 + num2 + num3) == 2020
                        return num1 * num2 * num3
                    end

                end

                #if we get here, it wasn't a match with the first, so put it back so it can be used again
                file_data.insert(index2, str2)

            end

        end


    end

end

solver = ExpenseReader.new("day1input.txt")
puts solver.solve_part_one
puts solver.solve_part_two