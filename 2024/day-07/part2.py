import copy

file = open("data.txt")
file_data = file.read()

lines = file_data.splitlines()

# new part 1 from left to right, and implemented part 2 with concat

part_1 = 0
part_2 = 0

def multiply(operands_left, curr_sum, goal_sum):
    if len(operands_left) > 0:
        operand = int(operands_left.pop(0))
        curr_sum *= operand
        if curr_sum == goal_sum:
            return True
    else:
        return False
    return add(copy.copy(operands_left), curr_sum, goal_sum) or multiply(copy.copy(operands_left), curr_sum, goal_sum) or concat(copy.copy(operands_left), curr_sum, goal_sum)
 

def add(operands_left, curr_sum, goal_sum):
    if len(operands_left) > 0:
        operand = int(operands_left.pop(0))
        curr_sum += operand
        if curr_sum == goal_sum:
            return True
    else:
        return False
    return add(copy.copy(operands_left), curr_sum, goal_sum) or multiply(copy.copy(operands_left), curr_sum, goal_sum) or concat(copy.copy(operands_left), curr_sum, goal_sum)

def concat(operands_left, curr_sum, goal_sum):
    if len(operands_left) > 0:
        operand = int(operands_left.pop(0))
        curr_sum = int(str(curr_sum) + str(operand))
        if curr_sum == goal_sum:
            return True
    else:
        return False
    return add(copy.copy(operands_left), curr_sum, goal_sum) or multiply(copy.copy(operands_left), curr_sum, goal_sum) or concat(copy.copy(operands_left), curr_sum, goal_sum)


for line in lines:
    line_info = line.split(": ")
    goal_sum = int(line_info[0])
    operands = line_info[1].split(" ")
    starter_sum = int(operands.pop(0))
    if add(copy.copy(operands), starter_sum, goal_sum) or multiply(copy.copy(operands), starter_sum, goal_sum):
        part_1 += goal_sum
    if add(copy.copy(operands), starter_sum, goal_sum) or multiply(copy.copy(operands), starter_sum, goal_sum) or concat(copy.copy(operands), starter_sum, goal_sum):
        # print(goal_sum)
        part_2 += goal_sum

print('part 1: ', part_1)
print('part 2: ', part_2)