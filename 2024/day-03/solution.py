import re

file = open("data.txt", "r")
file_data = file.read()

# pattern for both part 1 and 2
pattern = r"mul\((\d{1,3}),(\d{1,3})\)|(do\(\))|(don\'t\(\))"
matches = re.findall(pattern, file_data)

part_1_total = 0
part_2_total = 0
enabled = True


for mul in matches: # iterate through matches
    if mul[2] == "do()":    # handles enable instruction
        enabled = True
    elif mul[3] == "don't()":   # handles disable instruction
        enabled = False
    else:
        part_1_total += int(mul[0]) * int(mul[1])   # part 1 calculation
        if enabled:
            part_2_total += int(mul[0]) * int(mul[1])   # part 2 calculation

print('part 1: ', part_1_total)
print('part 2: ', part_2_total)