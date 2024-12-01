def solution
    file = File.read('example.txt').split("\n")
    seeds = []
    ranges = []
    overlaps = []
    maps = []
    category = ""
    categories = {'soil' => 0, 'fertilizer' => 1, "water" => 2, "light" => 3, "temperature" => 4, "humidity" => 5, "location" => 5}
   
    #iterate through lines
    file.each do |line|
        if line[0...5] == 'seeds'
            seeds = line.split(": ")[1].split(" ").map! { |s| s.to_i}
        elsif line.match?(/-to-(.*) /)
            category = line.match(/-to-(.*) /)[1]
        elsif line == ""
            
        else
            maps[categories[category]] ?
                maps[categories[category]].append(line.split(" ").map {|m| m.to_i}) :
                maps[categories[category]] = [line.split(" ").map {|m| m.to_i}]
        end
    end

    maps.each do |map|
        map.each do |mapping|
            mapping[2] = mapping[2] + mapping[1] - 1
        end
    end


    seeds.each_with_index do |s, i|
        if i % 2 == 0
            ranges[i / 2 + (i % 2)] = {"start" => s, "end" => seeds[i] + seeds[i+1] - 1}
        end
    end

    # iterate through each category
    maps.each do |map|
        # iterate through each mapping
        map.each do |mapping|
            # iterate through each range
            ranges.each_with_index do |range, i|
                if mapping[2] >= range["start"] && mapping[2] < range["end"] && mapping[1] <= range["end"]
                    overlaps.append([i, "L", mapping[2]])
                elsif mapping[1] <= range["end"] && mapping[1] > range["start"] && mapping[2] >= range["end"]
                    overlaps.append([i, "R", mapping[1]])
                elsif range["start"] > mapping[1] && range["end"] < mapping[2]
                    overlaps.append([i, "B", mapping[1], mapping[2]])
                end
            end

        end
        
        # split ranges
        overlaps.each do |r|
            if r[1] == "L"
                ranges.append({"start" => r[2]+1, "end" => ranges[r[0]]["end"]})
                ranges[r[0]]["end"] = r[2]
            elsif r[1] == "R"
                ranges.append({"start" => ranges[r[0]]["start"], "end" => r[2] - 1})
                ranges[r[0]]["start"] = r[2]
            elsif r[1] == "B"
                ranges.append({"start" => ranges[r[0]]["start"], "end" => r[2]-1}, {"start" => r[3]+1, "end" => ranges[r[0]]["end"]})
                ranges[r[0]]["start"] = r[2]
                ranges[r[0]]["end"] = r[3]
            end
            # p ranges
        end

        #convert ranges
        map.each do |mapping|
            ranges.map!.with_index do |range, i|
                if (range["start"] >= mapping[1] && range["start"] <= mapping[2])
                    range["start"] = range["start"] - (mapping[1] - mapping[0]).abs
                elsif (range["end"] >= mapping[1] && range["end"] <= mapping[2])
                    range["end"] = range["end"] - (mapping[1] - mapping[0]).abs
                end
                range
            end
        end
    end

    p seeds
    p maps
    print_range(ranges)
    p ranges.length
    # p overlaps
    p 'part 2: '
end

def print_range(ranges)
    ranges.each do |r|
        puts r["start"].to_s + " " + r["end"].to_s
    end
end

solution