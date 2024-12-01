def solution
    file = File.read('example.txt').split("\n")
    seeds = []
    seeds_part2 = []
    orig_seeds = []
    changed = []
    changed_part2 = []
    current_category_flag = ""

    #iterate through lines
    file.each do |line|
        # p line
        if line.match(/^seeds: /)
            # initial seeds
            s, initial_seeds = line.split(": ")
            seeds = initial_seeds.split(" ")
            seeds.map! {|s| s.to_i}
            # create seeds for part 2
            seeds.each_with_index { |s, i|
                if (i % 2 == 0)
                    seeds_part2[seeds_part2.length] = [s, s.to_i + seeds[i+1].to_i - 1] 
                end
            }
            # p seeds_part2
            orig_seeds = Array.new(seeds_part2)
            changed = Array.new(seeds.length, 0)
            changed_part2 = Array.new(seeds_part2.length, [0,0])
            # p changed_part2
        elsif line.match(/-to-(.*) /)
            # matching type of conversion
            category = line.match(/-to-(.*) /)
            current_category_flag = category[1]
            p category[1]
            # p current_category_flag
        elsif line == ""
            # empty line
            # p '-------'
            p seeds_part2
            changed.map! { |c| c = 0}
            changed_part2.map! { |c| c = [0,0]}
        else
            # call functions to process seed conversions
            seeds, changed = convert_numbers(seeds, line.split(" "), changed)
            seeds_part2, changed_part2 = convert_ranges(seeds_part2, line.split(" "), changed_part2)
        end
        # p seeds_part2
    end
    # p orig_seeds
    # p seeds_part2
    
    difference = []
    # seeds_part2.each_with_index { |e, i| difference[i] = seeds_part2[i] - orig_seeds[i]}


    p 'part 1: ' + (seeds.sort)[0].to_s
    p 'part 2: ' + (seeds_part2.flatten.sort)[0].to_s
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

# part 2
def convert_ranges(seeds, numbers, changed)
    range_to_add = []
    seeds.map!.with_index { |s, i|
        orig_s = Array.new(s)
        # if range is split in half
        # p numbers[1].to_i + numbers[2].to_i
        # p s
        p seeds
        if (numbers[1].to_i + numbers[2].to_i).to_i > orig_s[0].to_i && (numbers[1].to_i + numbers[2].to_i).to_i < orig_s[1].to_i && changed[i][0] != 1
            # p numbers
            # p 'hi'
            p s
            range_to_add = [numbers[1].to_i + numbers[2].to_i, orig_s[1]]
            # p range_to_add
            p 'first'
            seeds[seeds.length] = range_to_add
            changed[changed.length] = [0,0]
            s[1] = numbers[1].to_i - 1
            p seeds
            p 'what'
            p s
            p numbers
            changed[i][1] = 1
        end
        if (numbers[1].to_i) >= orig_s[0].to_i && (numbers[1].to_i) < orig_s[1].to_i && changed[i][0] != 1
            # p numbers
            # p 'hehe'
            p 'second'
            range_to_add = [s[0].to_i, numbers[1].to_i - 1]
            # p range_to_add
            seeds[seeds.length] = range_to_add
            changed[changed.length] = [0,0]
            s[0] = ((numbers[1].to_i) - ((numbers[1].to_i - numbers[0].to_i)).abs).abs
            p s
            p numbers
            changed[i][0] = 1
        end
        # processing each endpoint in range
        if (s[0] >= numbers[1].to_i && s[0] < (numbers[1].to_i + numbers[2].to_i) && changed[i][0] == 0)
            s[0] = (s[0] - (numbers[1].to_i - numbers[0].to_i)).abs
            changed[i][0] = 1
            # p numbers
        end
        if (s[1] >= numbers[1].to_i && s[1] < (numbers[1].to_i + numbers[2].to_i) && changed[i][1] == 0)
            s[1] = (s[1] - (numbers[1].to_i - numbers[0].to_i)).abs
            changed[i][1] = 1
            # p numbers
        end
        # p seeds
        
        s
    }
    #add additional endpoints
    # if range_to_add != []
    #     seeds[seeds.length] = range_to_add
    #     changed[changed.length] = [0,0]
    # end
    return [seeds, changed]
end

solution