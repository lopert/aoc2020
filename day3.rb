class Sloper
    def initialize
        @forest = File.read("day3input.txt").split("\n")
    end

    def solve

        position = 0

        # we start in the first row, so get rid of it
        @forest.shift

        @forest.each.inject(0) do |count, row|

            position += 3
            # if we go "off the map" loop around
            position = position % row.length if position >= row.length

            (row[position] == "#") ? count+1 : count
        end
    end
end

solver = Sloper.new()
pp solver.solve