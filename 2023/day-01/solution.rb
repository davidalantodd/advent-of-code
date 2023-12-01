# part 1 solution

def part1 
    # store values
    file = File.read('example.txt').split("\n")
    sum = 0

    # iterate through lines
    file.each do |line|
        # find the calibration values and add digits to sum
        sum += find_cal_vals(line)
    end

    return sum
end

# find calibration values

def find_cal_vals(line)
    # convert first and last character to integers
    v1 = line[0].to_i
    v2 = line[line.length-1].to_i
    if (v1 != 0) && (v2 != 0)
        # if they are both integers
        return (line[0] + line[line.length-1]).to_i
    elsif v1 == 0
        # if first is character, remove it and pass to function
        find_cal_vals(line[1..])
    elsif v2 == 0
        #if last is character, remove it and pass to function
        find_cal_vals(line[0...(line.length-1)])
    end
end

# part 2 solution

# declare array of digit strings
@digits = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

def part2
    # store values
    file = File.read('data.txt').split("\n")
    sum = 0

    # iterate through lines
    file.each do |line|
        # find the calibration values and add digits to sum
        sum += find_cal_vals_part2(line)
    end

    return sum
end

# find calibration values, including digit strings (part 2)

def find_cal_vals_part2(line)
    # create varibles to store indices of found digit strings
    first = -1
    last = -1

    # check first part of string if any of digit strings match
    @digits.each_with_index do |d, i|
        if line[0...d.length] == d
            first = i
            break
        end
    end
    # check end of string if any of the digit strings match
    @digits.each_with_index do |d, i|
        if line[line.length-d.length...] == d
            last = i
            break
        end
    end

    # grab the first and last chars and convert to integer
    v1 = line[0].to_i
    v2 = line[line.length-1].to_i

    if (first != -1) && (last != -1)
        # if they are both digit strings, return the two digit strings in integer form
        return ("#{first+1}" + "#{last+1}").to_i
    elsif (v1 != 0) && (last != -1)
        # if the first is an actual integer and the last is a digit string, return in integer form
        return ("#{line[0]}" + "#{last+1}").to_i
    elsif (first != -1) && (v2 != 0)
        # if the first is a digit string and the last is an actual integer, return in integer form
        return ("#{first+1}" + "#{line[line.length-1]}").to_i
    elsif (v1 != 0) && (v2 != 0)
        # if they are both actual integers, return them
        return (line[0] + line[line.length-1]).to_i
    elsif first == -1 && v1 == 0
        # if no actual integer or digit string is found at the beginning, remove first char and pass to function
        find_cal_vals_part2(line[1..])
    elsif last == -1 && v2 == 0
        # if no actual integer or digit string is found at the end, remove last char and pass to function
        find_cal_vals_part2(line[0...(line.length-1)])
    end
end

# call the function and print result
p part1
p part2


