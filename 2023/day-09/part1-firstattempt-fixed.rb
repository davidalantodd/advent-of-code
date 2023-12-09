def solution file = File.read('data.txt').split("\n")

    sum = []
    file.each do |line|
        history = line.split(" ").map{ |n| n.to_i }
        # p history p history[-1]
        # p 'SUM: ' + (find_diff(history).to_i + history[-1]).to_s
        sum.append(find_diff(history).to_i + history[-1])
    end
    # p sum
    p 'part1: ' + sum.reduce(0){|v, c| (v + c)}.to_s
    return sum.reduce(0){|v, c| v - c}.to_s
end

def find_diff(history)
    diff = []
    history.each_with_index do |h, i|
        break if (i == history.length - 1)
        diff[i] = (history[i+1] - h)
    end
    # p history
    # p diff
    # fixed the following line -- used to be (diff.reduce(0){|v, s| v+s} == 0)
    if (diff == Array.new(diff.length, 0))
        # p diff
        return 0
    else
        # p diff[-1]
        return diff[-1].to_i + find_diff(diff).to_i
    end
end

solution