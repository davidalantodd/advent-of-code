data = File.read("data.txt").split

arr = data[0].split('')
i = 0
part1_solution = 0
part2_solution = 0

#checking for 4 unique chars
while i < arr.length do
    # p arr[i..i+3].uniq
    if (arr[i..i+3].uniq.length == 4)
        part1_solution = i.dup + 4
        break
    end
    i = (i.dup + 1)
end

#part 2 - checking for 14 unqiue chars
i = 0
while i < arr.length do
    if (arr[i..i+13].uniq.length == 14)
        part2_solution = i.dup + 14
        break
    end
    i = (i.dup + 1)
end

p "part 1 solution: " + String(part1_solution)
p "part 2 solution: " + String(part2_solution)