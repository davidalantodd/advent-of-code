def solution
    grid = File.read('data.txt').split("\n")

    grid.each_with_index do |line, index|
        grid[index] = line.split("")
    end

    # print_grid(grid)

    # gather part numbers and part indexes
    part_numbers = []
    part_indexes = []

    # iterate through grid
    grid.each_with_index do |row, row_index|
        current_part_number = ""
        current_part_indexes = []
        row.each_with_index do |element, col_index|
            # check if it is a number
            if element.to_i != 0 || element == "0"
                # if so, add it to the current part number
                current_part_number += element
                current_part_indexes.push([row_index,col_index])
            elsif
                #if not, push any existing part number onto the part_numbers array
                if current_part_number != ""
                    part_numbers.push(current_part_number)
                    part_indexes.push(current_part_indexes)
                end
                current_part_number = ""
                current_part_indexes = []
            end
        end
        # push any existing part number onto the part_numbers array (edge case for end of row)
        if current_part_number != ""
            part_numbers.push(current_part_number)
            part_indexes.push(current_part_indexes)
        end
    end

    # check numbers to see if they are actually parts (part 1), and check for gears (part 2)
    actual_parts, gears = check_for_machine_parts(part_numbers, part_indexes, grid)
    
    # calculate sum of parts (part 1)
    sum = actual_parts.reduce(0) {|sum, curr_part| sum + curr_part}

    # calculate sum of gear ratios (part 2)
    ratio_sum = calculate_ratios(gears)

    # print solutions
    p 'part 1: ' + sum.to_s
    p 'part 2: ' + ratio_sum.to_s
end

# helper to check to see if a number is a part number, and to find gears
def check_for_machine_parts(part_numbers, part_indexes, grid)
    actual_parts = []
    gears = {}
    # iterate through numbers to check if it's a part
    part_indexes.each_with_index do |indexes, index|
        this_is_a_part = false
        # check every index to check the adjacent elements for a symbol
        indexes.each do |pair|
            # use this function to check for symbols and *s
            symbol, gear = check_symbol(pair, grid)
            if symbol == true
                this_is_a_part = true
                # if there was a *...
                if gear.length > 0
                    # add the part number to the gear index hash
                    if gears[gear] == nil
                        gears[gear] = [part_numbers[index]]
                    elsif 
                        if !(gears[gear].include?(part_numbers[index]))
                            gears[gear].push(part_numbers[index])
                        end
                    end
                end
            end
        end
        # if it's a part number, add it to the part number array
        if this_is_a_part == true
            actual_parts.push(part_numbers[index].to_i)
        end
    end
    return [actual_parts, gears]
end


# helper to check to see if there is a symbol adjacent to a part number's digit
def check_symbol(pair, grid)
    found_a_symbol = false
    gear_index = []
    # check around the entire digit
    for i in (pair[0]-1)..(pair[0]+1)
        for j in (pair[1]-1)..(pair[1]+1)
            # make sure we're not going out of the bounds of the grid
            if (i < grid.length && i >= 0)
                if (j < grid[i].length && j >= 0)
                    # check to see if it's a symbol
                    if (grid[i][j].to_i == 0 && grid[i][j] != "0") && (grid[i][j] != ".")
                        # check to see if it is a * to store potential gear index
                        if grid[i][j] == "*"
                            gear_index = [i, j]
                        end
                        found_a_symbol = true
                    end

                end
            end
        end
    end
    # return symbol for part 1 (part number) and gear index (part 2)
    return [found_a_symbol, gear_index]
end

def calculate_ratios(gears)
    sum = 0
    gears.each do |gear_index, parts|
        # make sure two part numbers exist - that makes it a gear
        if parts.length == 2
            sum += parts[0].to_i * parts[1].to_i
        end
    end
    return sum
end

def print_grid(grid)
    grid.each do |row|
        row.each do |el|
            print el
        end
        print "\n"
    end
end

solution