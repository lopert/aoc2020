class JoltageAdapter
    attr_accessor :joltage, :input_joltage
    def initialize (oj)
        @joltage = oj
        @input_joltage = [@joltage - 3, @joltage - 2, @joltage - 1]
    end
end

class Device
    attr_accessor :joltage
    def initialize (adapters)
        max_adapter = adapters.max_by {|adapter| adapter.input_joltage.max}
        @joltage = max_adapter.joltage + 3
    end
end

class AdapterArray
    def initialize
        array = File.read("day10input.txt").split("\n")

        @adapters = array.map do |adapter|
            JoltageAdapter.new(adapter.to_i)
        end
        
    end

    def solve

        # 0 jolt charging outlet
        outlet = JoltageAdapter.new(0)
        @adapters.push(outlet)

        # final jump to device
        dev = Device.new(@adapters)
        @adapters.push(dev)

        @adapters.sort_by! {|adapter| adapter.joltage}

        voltage_jumps = []

        @adapters.each_cons(2) do |c|
            voltage_jumps << c[1].joltage - c[0].joltage
        end

        # puts "one jumps: #{voltage_jumps.count(1)}, three jumps: #{voltage_jumps.count(3)}"

        voltage_jumps.count(1) * voltage_jumps.count(3)
    end

end

class AdapterArrayV2 < AdapterArray

    def initialize
        super

        # final jump to device
        dev = Device.new(@adapters)
        @adapters.push(dev)

        @adapters.sort_by! {|adapter| adapter.joltage}
        @available_joltages = @adapters.map { |adapter| adapter.joltage }

    end

    def solve_recursive

        nodes = [0]
        count = 0

        while nodes.any?
            next_node = nodes.shift
            # puts "Now parsing node: #{next_node}"
            # puts "Nodes remaining: #{nodes.size}"

            if next_node == @available_joltages.max
                count += 1
            else

                can_link_to = @available_joltages.select do |node|
                    diff = node - next_node
                    diff <= 3 && diff > 0
                end

                nodes.concat(can_link_to)
            end
        end

        count

    end

    def solve_reddit #stolen from https://www.reddit.com/r/adventofcode/comments/ka8z8x/2020_day_10_solutions/gfcaf2q/
        c = [nil,nil,nil,1]
        @available_joltages.each { |i| c[i+3] = c[i..i+2].compact.sum }
        c.last
    end

    def solve_math # adapting the reddit solution - using hashes instead

        # start at 1 path on the outlet
        # this hash will be
        # key:      the adapter's joltage
        # value:    the accumulated paths to get to this adapter
        accumulator = {0 => 1}

        # for each joltage
        @available_joltages.each do |joltage|

            # for each joltage that can be adapted to it
            accumulator[joltage] = (1..3).map do |diff|
                accumulator[joltage-diff] # access the stored accumulated paths
            end.compact.sum # and sum the accumulated paths and store them as the value for this joltage 
        end

        accumulator[@available_joltages.last]

    end

end

aa = AdapterArray.new
puts "Part 1: #{aa.solve}"

aa_two = AdapterArrayV2.new
# puts "Part 2 (Recursive): #{aa_two.solve_recursive}" # too long or memory error on large input
puts "Part 2 (Reddit): #{aa_two.solve_reddit}"
puts "Part 2 (Math): #{aa_two.solve_math}"

# code graveyard of my previous no-looking-up attempts
def solve_math_attempt

    # 0 jolt charging outlet
    outlet = JoltageAdapter.new(0)
    @adapters.push(outlet)

    # final jump to device
    dev = Device.new(@adapters)
    @adapters.push(dev)

    @adapters.sort_by! {|adapter| adapter.joltage}


    # we only care about the joltages
    available_joltages = @adapters.map { |adapter| adapter.joltage }

    count = 0

    available_joltages.each do |joltage|

        # p joltage

        can_link_to = available_joltages.select do |node|
            diff = node - joltage
            diff <= 3 && diff > 0
        end

        is_linked_to = available_joltages.select do |node|
            diff = joltage - node
            diff <= 3 && diff > 0
        end

        # count += can_link_to.size
        # count *= is_linked_to.size

        impact = (can_link_to.size) * (is_linked_to.size) - 1

        puts "Adapter #{joltage} impact: #{impact}"

        count += impact unless impact <= 0




        # puts 2**(can_link_to.size-1) unless (can_link_to.size - 1 <= 0)

        # puts "Joltage #{joltage} can link to #{can_link_to}, size #{can_link_to.size}"

        # puts "Increasing current count of #{count} by #{can_link_to.size}"
        # count *= 2**(can_link_to.size-1) unless can_link_to.size <= 0


    end
    puts "COUNT: #{count}"
    # puts count.class
    # p count

end
