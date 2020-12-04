class Sloper
    def initialize
        @forest = File.read("day3input.txt").split("\n")
    end

    def solve
        traverse(@forest)
    end

    def traverse(forest, slope = {right: 3, down: 1 } )
        position = -slope[:right]
        
        forest.each_with_index.inject(0) do |count, line|

            row = line[0]
            index = line[1]
            # puts "INDEX: #{index}, POS: #{position}, COUNT: #{count}"

            # if index % slope[:down] == 0
            #     position += slope[:right]
            #     # if we go "off the map" loop around
            #     position = position % row.length if position >= row.length

            #     (row[position] == "#") ? count+1 : count
            # else
            #     count
            # end  
            


            count unless (index % slope[:down] == 0)
            # puts "made it passed: #{index % slope[:down] == 0}"
            
            position += slope[:right]
            # if we go "off the map" loop around
            position = position % row.length if position >= row.length

            (row[position] == "#") ? count+1 : count



        end
    end

end

class SloperV2 < Sloper
    def solve
        puts traverse(@forest, {right: 1, down: 1 })
        puts traverse(@forest, {right: 3, down: 1 })
        puts traverse(@forest, {right: 5, down: 1 })
        puts traverse(@forest, {right: 7, down: 1 })
        puts traverse(@forest, {right: 1, down: 2 })

        # traverse(@forest, {right: 1, down: 1 }) *
        # traverse(@forest, {right: 3, down: 1 }) *
        # traverse(@forest, {right: 5, down: 1 }) *
        # traverse(@forest, {right: 7, down: 1 }) *
        # traverse(@forest, {right: 1, down: 2 })
    end
end

puts "PART 1"
solver = Sloper.new()
pp solver.solve

puts "PART 2"
solver2 = SloperV2.new()
pp solver2.solve