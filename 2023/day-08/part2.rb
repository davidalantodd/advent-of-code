def solution
    file = File.read('data.txt').split("\n")
    instructions = ""
    elements = {}
    file.each_with_index do |line, i|
        if i == 0
            instructions = line
        elsif i > 1
            element = line.match(/(\w*) = \((\w*), (\w*)\)/)
            elements[element[1]] = [element[2], element[3]]
        end

    end
    
    # update instructions to indexes
    instructions.gsub!(/L/, "0")
    instructions.gsub!(/R/, "1")

    instructions = instructions.split("")
    pointer = 0
    current_locations = []
    # find starting locations (--A)
    elements.keys.each do |e|
       if e.match?(/(\w\wA)/)
            current_locations.append(e.match(/(\w\wA)/)[1])
       end
    end

    # take one step with the first instruction
    current_locations.map! do |l|
        l = elements[l][instructions[pointer].to_i]
    end
    steps_for_each = []
    pointer+=1
    steps = 1

    # iterate through each location
    current_locations.map! do |c|
        steps = 1
        pointer = 1
        # iterate through steps for just one location at a time
        loop do
            # update location to next step
            c = elements[c][instructions[pointer].to_i]
            steps+=1
            # check to see if at end for this location (--Z)
            if c.match?(/(\w\wZ)/)
                # add the current steps to the array
                steps_for_each.append(steps)
            end
            # break if at the end (--Z)
            break if c.match?(/(\w\wZ)/)
            pointer+=1
            # reset pointer to beginning
            if pointer >= instructions.length
                pointer = 0
            end
        end     
        c
    end

    # calculate the least common multiple of all steps for each location
    solution = lcmm(steps_for_each)

    p 'part2: ' + solution.to_s
end

#find greatest common demonenator via euclidiean algorithm
def gcd(a, b)
    # loop until taking mod of both brings one down to zeo
    while (b != 0)
        temp = b
        b = a % b
        a = temp
    end
    return a
end

# calculate least common multiple
def lcm(a, b)
    return (a * b / gcd(a, b))
end

# calculate least common multiple for more than two numbers
def lcmm(steps)
    # if just two numbers left, calculate the lcm
    if steps.length == 2
        lcm(steps[0], steps[1])
    else
        #take one number out
        current_multiple = steps[0]
        # p current_multiple
        steps.shift()
        # calculate the lcm with the number and the result of the recursive call with the rest
        return lcm(current_multiple, lcmm(steps))
    end
end

solution