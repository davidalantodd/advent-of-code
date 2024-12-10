import copy

file = open("data.txt")
file_data = file.read()

lines = file_data.splitlines()

# part 1 - initial version right to left with divide/substract

def divide(operands_left, curr_sum, goal_sum):
    if len(operands_left) > 0:
        operand = int(operands_left.pop(0))
        curr_sum /= operand
        if curr_sum == goal_sum:
            return True
    else:
        return False
    return subtract(copy.copy(operands_left), curr_sum, goal_sum) or divide(copy.copy(operands_left), curr_sum, goal_sum)

def subtract(operands_left, curr_sum, goal_sum):
    if len(operands_left) > 0:
        operand = int(operands_left.pop(0))
        curr_sum -= operand
        if curr_sum == goal_sum:
            return True
    else:
        return False
    return subtract(copy.copy(operands_left), curr_sum, goal_sum) or divide(copy.copy(operands_left), curr_sum, goal_sum)


part_1 = 0

for line in lines:
    line_info = line.split(": ")
    starter_sum = int(line_info[0])
    operands = line_info[1].split(" ")
    operands.reverse()
    goal_sum = int(operands.pop())
    if subtract(copy.copy(operands), starter_sum, goal_sum) or divide(copy.copy(operands), starter_sum, goal_sum):
        part_1 += starter_sum

print('part 1: ', part_1)