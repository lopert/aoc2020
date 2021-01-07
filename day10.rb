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

        puts "one jumps: #{voltage_jumps.count(1)}, three jumps: #{voltage_jumps.count(3)}"

        puts "Answer: #{voltage_jumps.count(1) * voltage_jumps.count(3)}"
    end

end

aa = AdapterArray.new
aa.solve
# device = Device.new(aa.adapters)