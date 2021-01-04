class FormAnalyzer

    def initialize
        @data_by_group = File.read("day6input.txt").split("\n\n")
    end

    def solve

        result = 0
        @data_by_group.each do |group_data|
            result += group_yes(group_data)
        end

        puts result

    end

    def group_yes(group_data)
        
        yes_values = ""

        group_data.split("\n").each do |person_data|
            yes_values << person_data
        end

        yes_values.chars.uniq.count

    end

end

class FormAnalyzerV2 < FormAnalyzer
    def group_yes(group_data)
        group_data.split("\n").inject do |result, person_data|
            (result.split('') & person_data.split('')).join
        end.length
    end
end

solver = FormAnalyzer.new()
solver.solve

solver_two = FormAnalyzerV2.new()
solver_two.solve
