def solution
    file = File.read('data.txt').split("\n")
    seeds = []
    orig_seeds = []
    changed = []
    current_category_flag = ""

    #iterate through lines
    file.each do |line|
        if line.match(/^seeds: /)
            # initial seeds
            s, initial_seeds = line.split(": ")
            seeds = initial_seeds.split(" ")
            seeds.map! {|s| s.to_i}
            changed = Array.new(seeds.length, 0)
        elsif line.match(/-to-(.*) /)
            # matching type of conversion
            category = line.match(/-to-(.*) /)
            current_category_flag = category[1]
            p category[1]
        elsif line == ""
            # empty line
            changed.map! { |c| c = 0}
        else
            # call functions to process seed conversions
            seeds, changed = convert_numbers(seeds, line.split(" "), changed)
        end
    end
    


    p 'part 1: ' + (seeds.sort)[0].to_s
end

# part 1
def convert_numbers(seeds, numbers, changed)
    seeds.map!.with_index { |s, i| 
        if (s >= numbers[1].to_i && s < (numbers[1].to_i + numbers[2].to_i) && changed[i] == 0)
            s = (s - (numbers[1].to_i - numbers[0].to_i)).abs
            changed[i] = 1
        end
        s
    }
    return [seeds, changed]
end

solution