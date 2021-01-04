class Bag

    attr_accessor :color, :contains

    def initialize(color, contains)
        @color = color
        @contains = contains
    end

end

class RuleReader

    def initialize
        @rules = File.read("day7input.txt").split("\n")

        @bags = []

        @rules.each do |rule|
            @bags << create_bag(rule)
        end

        # p @bags
    end

    def create_bag(rule_line)

        color = rule_line.split(" bags contain ")[0]

        # vibrant salmon bags contain 1 vibrant gold bag, 2 wavy aqua bags, 1 dotted crimson bag.
        # take last half of statement
        contains = rule_line.split(" bags contain ")[1]

        # split contained colors
        contains = contains.split(", ")

        # format data into a hash
        contained = []
        contains.each do |data|
            if data.include?("no other")
                contained = []
            else
                # drop last word
                data = data.split(" ")[0..-2]
                contained_color = "#{data[1]} #{data[2]}"
                contained_qty = data[0]
                contained << { color: contained_color, quantity: contained_qty }
            end
        end

        Bag.new(color, contained)
    end

    def solve(initial_color)

        bag_list = []
        checklist = [initial_color]

        while checklist.any?
            
            color = checklist.shift
            # puts "Checklist: #{checklist}"

            # look through every rule-bag
            @bags.each do |bag|

                # and that bags contents
                bag.contains.each do |contained_bag|
                    
                    # to see if that bag contains the color we want
                    if contained_bag[:color] == color

                        # puts "#{bag.color} bags contain #{color}"

                        # found a bag that has the color we want
                        bag_list << bag.color

                        # now, check for bags that contain THIS bag
                        checklist << bag.color
                    end

                end

            end

        end

        puts "Found #{bag_list.uniq.count} bags that could contain #{initial_color}."

    end

end

class RuleReaderV2 < RuleReader
    def solve(color)
        count = 0
        bag_queue = @bags.select {|bag| bag.color == color}

        while bag_queue.any?
            # p bag_queue
            current_bag = bag_queue.shift
            # p current_bag
        
            current_bag.contains.each do |contained_bag|

                # puts "A #{current_bag.color} bag contains #{contained_bag[:quantity].to_i} #{contained_bag[:color]} bags."
                count += contained_bag[:quantity].to_i
                bag = @bags.select {|bag| bag.color == contained_bag[:color]}
                
                contained_bag[:quantity].to_i.times do
                    
                    bag_queue << bag[0]
                end
            end
        end

        puts "A #{color} bag must contain #{count} bags."

    end
end

solver = RuleReader.new
solver.solve("shiny gold")

# 574 too high
# 573 too high

solver_two = RuleReaderV2.new
solver_two.solve("shiny gold")

# 358 too low