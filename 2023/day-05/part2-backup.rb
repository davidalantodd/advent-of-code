def solution
    file = File.read('data.txt').split("\n")
    seeds = []
    seeds_part2 = []
    changed_part2 = []
    current_category_flag = ""
    current_conversion_mappings = []
    overlaps = []
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
            changed_part2 = Array.new(seeds_part2.length, [0,0])
            orig_seeds = Array.new(seeds_part2)
        elsif line.match(/-to-(.*) /)
            # matching type of conversion
            category = line.match(/-to-(.*) /)
            current_category_flag = category[1]
            # p category[1]
            # p current_category_flag
        elsif line == ""
            # p "EMPTY"
            # empty line
            # p seeds_part2
            # p current_conversion_mappings
            if (current_conversion_mappings != [])
                overlaps = check_for_overlaps(seeds_part2, current_conversion_mappings, overlaps)
                # p overlaps
                seeds_part2 = split_ranges(seeds_part2, current_conversion_mappings, overlaps)
                seeds_part2 = convert_ranges(seeds_part2, current_conversion_mappings)
                    p seeds_part2.length
                current_conversion_mappings = []
                overlaps = []
            end
            
        else
            current_conversion_mappings.append(line)
            # call functions to process seed conversions
        end
        # p seeds_part2
    end
    # p 'hehe'
    overlaps = (check_for_overlaps(seeds_part2, current_conversion_mappings, overlaps))
    # p overlaps
    seeds_part2 = split_ranges(seeds_part2, current_conversion_mappings, overlaps)
    seeds_part2 = convert_ranges(seeds_part2, current_conversion_mappings)

    current_conversion_mappings = []
    overlaps = []
    # p seeds_part2
    # p orig_seeds
    # p seeds_part2
    # p current_conversion_mappings
    difference = []
    # seeds_part2.each_with_index { |e, i| difference[i] = seeds_part2[i] - orig_seeds[i]}

    # p seeds_part2.flatten.sort
    p 'part 2: ' + (seeds_part2.flatten.sort)[0].to_s
end

# part 1
def check_for_overlaps(seeds, mappings, overlaps)
    seeds.each_with_index do |s, i| 
        mappings.each do |m|
            map = m.split(" ").map! {|e| e.to_i}
            # p 'lala'
            # p 'map[1]: ' + map[1].to_s
            # p 'map[~2]: ' + (map[1] + map[2] - 1).to_s
            # p 's[0]: ' + s[0].to_s
            # p 's[1]: ' + s[1].to_s
            # option 1, map to the right - 1/2
            if ((map[1] <= s[1]) && (map[1] > s[0]) && ((map[1] + map[2] - 1) >= s[1])) # 
                overlaps[overlaps.length] = [i, map[1], 'right']
            #option 2, map to the left 1/2
            elsif (((map[1] + map[2] - 1) < s[1]) && ((map[1] + map[2] - 1) >= s[0]) && (map[1] <= s[0])) # 
                overlaps[overlaps.length] = [i, (map[1] + map[2] - 1), 'left']
            #option 3, map is inside the seed range, split twice
            elsif ((map[1] > s[0]) && ((map[1] + map[2] - 1) < s[1]))
                overlaps[overlaps.length] = [i, map[1], (map[1] + map[2] - 1)]
            end
            # p 'over'
            # p overlaps
        end
    end
    return overlaps
end


def split_ranges(seeds, mappings, overlaps)
    # p overlaps
    # p "OVERLAPS TIME"
    overlaps.each do |o|
        # p 'o[0]: ' + o[0].to_s
        # p 'o[1]: ' + o[1].to_s
        # p 'o[2]: ' + o[2].to_s
        split_range = []

        if (o[2] == 'right')
            split_range = [o[1], seeds[o[0]][1]]
            seeds[o[0]][1] = o[1] - 1 
            seeds.append(split_range)
            # p 'hi right'
        elsif (o[2] == 'left')
            split_range = [seeds[o[0]][0], o[1]]
            seeds[o[0]][0] = o[1] + 1
            seeds.append(split_range)
            # p 'hi left'
        else
            # p 'seeds:'
            # p seeds
            # p 'first one'
            # p [seeds[o[0]], o[1] - 1]
            # p 'second append'
            # p [o[2] + 1, seeds[o[0]][1]]
            seeds.append([seeds[o[0]][0], o[1] - 1], [o[2] + 1, seeds[o[0]][1]])
            seeds[o[0]] = [o[1], o[2]]
            # seeds += split_ranges
            # seeds.delete_at(o[0])
            # p 'um'
            # p seeds
            # p 'hi both'
        end
    end
    # p seeds
    # seeds.each_with_index do |e, i|
    #     if e[0] > e[1]
    #         seeds.delete_at(i)
    #     end
    # end
    # p seeds
    return seeds
end

# part 2
def convert_ranges(seeds, mappings)
    # changed = Array.new(seeds.length, [0,0])
    changed = []
    # p seeds
    mappings.each do |map|
        # p changed
        m = map.split(" ").map! {|e| e.to_i}
        seeds.map!.with_index do |s, i|
            # p s 
            # p m
            # p seeds
            # processing each endpoint in range
            # p m
            if !changed.include?(i)
                if (s[0] >= m[1].to_i && s[0] < (m[1].to_i + m[2].to_i))
                    s[0] = (s[0] - (m[1].to_i - m[0].to_i)).abs
                    changed.append(i)
                end
                if (s[1] >= m[1].to_i && s[1] < (m[1].to_i + m[2].to_i))
                    s[1] = (s[1] - (m[1].to_i - m[0].to_i)).abs
                    changed.append(i)
                end
            end
            s
        end
        
    end
    # p seeds

    return seeds
end

solution