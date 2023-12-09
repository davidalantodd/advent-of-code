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

    # change instructions to indexes
    instructions.gsub!(/L/, "0")
    instructions.gsub!(/R/, "1")
    instructions = instructions.split("")
    pointer = 0
    current_location = elements["AAA"][instructions[pointer].to_i]
    pointer+=1
    steps = 1
    # iterate through instructions
    loop do
        break if current_location == "ZZZ"
        # update curent location
        current_location = elements[current_location][instructions[pointer].to_i]
        # update pointer for instructino
        pointer+=1
        steps+=1
        # reset pointer to beginning
        if pointer >= instructions.length
            pointer = 0
        end
    end

    p 'part1: ' + steps.to_s
end

solution