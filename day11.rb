class SeatingSystem

    def initialize
        @states = File.read("day11input.txt").split("\n")

        @states.map! do |row|
            row.split("")
        end

    end

    def print_state(state)
        state.map {|row| p row }.join("")
    end

    def solve

        count
        stabilize
        count
        
        
    end

    def stabilize

        pre_round_result = []
        @round_count = 0

        # perform rounds until stabilization
        while pre_round_result != @states
            @round_count += 1
            # puts "Round: #{@round_count}"
            
            #deep copy - https://stackoverflow.com/a/2039274
            pre_round_result = Marshal.load(Marshal.dump(@states))
            @states = round
        end

        puts "Stabilized on round #{@round_count}"
    end

    def count
        count_occupied = 0
        count_no_chair = 0
        count_vacant = 0

        @states.each do |row|
            row.each do |seat|
                count_occupied += 1 if seat == "#"
                count_no_chair += 1 if seat == "."
                count_vacant += 1 if seat == "L"
            end
        end

        puts "===> Occupied seats: #{count_occupied}"
        puts "Floor tiles: #{count_no_chair}"
        puts "Empty seats: #{count_vacant}"
        puts "Total area: #{count_occupied + count_no_chair + count_vacant}"
    end

    def count_adjacent(rindex,cindex)
        adj_count = 0

        height = @states.size - 1
        width = @states[0].size - 1
        
        #ortho
        if rindex > 0 #up
            adj_count +=1 if @states[rindex-1][cindex] == "#"
        end

        if rindex < height #down
            adj_count +=1 if @states[rindex+1][cindex] == "#"
        end

        if cindex > 0 #left
            adj_count +=1 if @states[rindex][cindex-1] == "#"
        end

        if cindex < width #right
            adj_count +=1 if @states[rindex][cindex+1] == "#"
        end
     
        #diag
        if rindex > 0 and cindex > 0 #up left
            # puts "A" if (rindex == 1 and cindex == 1)
            adj_count +=1 if @states[rindex-1][cindex-1] == "#"
        end

        if rindex > 0 and cindex < width #up right
            # puts "B" if (rindex == 1 and cindex == 1)
            adj_count +=1 if @states[rindex-1][cindex+1] == "#"
        end

        if rindex < height and cindex > 0 #down left
            # puts "C" if (rindex == 1 and cindex == 1)
            adj_count +=1 if @states[rindex+1][cindex-1] == "#"
        end

        if rindex < height and cindex < width #down right
            # puts "D" if (rindex == 1 and cindex == 1)
            adj_count +=1 if @states[rindex+1][cindex+1] == "#"
        end

        # puts "#{adj_count}" if (rindex == 1 and cindex == 1)

        adj_count
    end


    def round
        @states.each_with_index.map do |row, rindex|
            row.each_with_index.map do |col, cindex|

                if @states[rindex][cindex] == "."
                    "." #empty space, ignore
                else
                    adj_count = count_adjacent(rindex,cindex)

                    #determine character
                    if (@states[rindex][cindex] == "L" and adj_count == 0)
                        "#"
                    elsif (@states[rindex][cindex] == "#" and adj_count >= 4)
                        "L"
                    else
                        @states[rindex][cindex]
                    end
                end
            end
        end
    end
end

solver = SeatingSystem.new
solver.solve
# puts "Part 1: #{solver.solve}"
# 2417 too high
# 2415 too high
# 2406 too high