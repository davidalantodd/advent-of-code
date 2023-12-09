def solution
    # refactored solution
    file = File.read('data.txt').split("\n")

    sum = file.map do |line|
        history = line.split(" ").map(&:to_i)
        # find last element in differences array and add to sum array
        find_diff(history)[-1] + history[-1]
    end
    p 'part1: ' + sum.sum.to_s
    return sum.sum
end

def find_diff(history)
    # iterate through histories to calculate differences
    diff = history.each_cons(2).map{|v1, v2| v2 - v1}

    # check if all elements = 0
    if (diff == Array.new(diff.length, 0))
        return 0
    else
        # if they don't, append last diff element + last element of the result of recursive function call: find_diff(diff)
        diff << (find_diff(diff)[-1] + diff[-1])
    end
end

solution