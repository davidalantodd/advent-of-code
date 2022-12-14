file = open("example.txt", "r")
file_data = file.read()
moves = file_data.splitlines()

#define starting positions
H = [4,0]
T = [4,0]

print(moves)
print(H)
print(T)
#create dict to track where visited
visited = {}

#check if T needs to move left
def check_left():
    if H[1] - T[1] < -1:
        return H,[T[0],T[1]-1]
    else:
        return H, T

#check if T needs to move right
def check_right():
    return H,[T[0],T[1]+1]
   

#check if T needs to move up
def check_up():
    return H,[T[0]-1,T[1]]
    

#check if T needs to move down
def check_down():
    return H,[T[0]+1,T[1]]
    

#check if T needs to move up/right diagonally      ##EDIT THESE FOUR
def check_up_right_diag():
    return H,[T[0]-1,T[1]+1]

#check if T needs to move down/right diagonally
def check_down_right_diag():
    if H[0] - T[0] > 0:
        return H,[T[0]+1,T[1]+1]
    else:
        return H, T

#check if T needs to move up/left diagonally
def check_up_left_diag():
    if H[0] - T[0] < 0:
        return H,[T[0]-1,T[1]-1]
    else:
        return H, T

#check if T needs to move down/left diagonally
def check_down_left_diag():
    if H[0] - T[0] > 0:
        return H,[T[0]+1,T[1]-1]
    else:
        return H, T

for move in moves:
    [direction, count] = move.split(' ')
    print(move)
    for i in range(int(count)):
        #check direction to make move(s)
        
        if direction == "R":
            H[1]+=1 #moving head
            if ((H[0] - T[0] == 1 or H[0] - T[0] == -1) and (H[1] - T[1] == 1 or H[1] - T[1] == -1)) or ((H[0] - T[0] == 0) and (H[1] - T[1] == 1 or H[1] - T[1] == -1)) or ((H[0] - T[0] == 1 or H[0] - T[0] == -1) and (H[1] - T[1] == 0)) or ((H[0] - T[0] == 0) and (H[1] - T[1] == 0)):
                print('no need to move')
            else:
                #check if we need to do a diagonal move or not
                if H[0] != T[0]:
                    if H[0] - T[0] < 0:
                        if H[1] - T[1] > 0:
                            H,T = check_up_right_diag()
                        else:
                            H,T = check_right()
                    elif H[0] - T[0] > 0: 
                        if H[1] - T[1] > 0:
                            H,T = check_down_right_diag()
                        else:
                            H,T = check_right()
                    else:
                        H,T = check_right()
                else:
                    H,T = check_right()
                        #moving tail
        elif direction == "L":
            H[1]-=1
            if ((H[0] - T[0] == 1 or H[0] - T[0] == -1) and (H[1] - T[1] == 1 or H[1] - T[1] == -1)) or ((H[0] - T[0] == 0) and (H[1] - T[1] == 1 or H[1] - T[1] == -1)) or ((H[0] - T[0] == 1 or H[0] - T[0] == -1) and (H[1] - T[1] == 0)) or ((H[0] - T[0] == 0) and (H[1] - T[1] == 0)):
                print('no need to move')
            else:
                #check if we need to do a diagonal move or not
                if H[0] != T[0]:
                    if H[0] - T[0] < 0:
                        if H[1] - T[1] < 0:
                            H,T = check_up_left_diag()
                        else:
                            H,T = check_left()
                    elif H[0] - T[0] > 0:
                        if H[1] - T[1] < 0: 
                            H,T = check_down_left_diag()
                        else:
                            H,T = check_left()
                    else:
                        H,T = check_left()
                else:
                    H,T = check_left()
        elif direction == "U":
            H[0]-=1
            if ((H[0] - T[0] == 1 or H[0] - T[0] == -1) and (H[1] - T[1] == 1 or H[1] - T[1] == -1)) or ((H[0] - T[0] == 0) and (H[1] - T[1] == 1 or H[1] - T[1] == -1)) or ((H[0] - T[0] == 1 or H[0] - T[0] == -1) and (H[1] - T[1] == 0)) or ((H[0] - T[0] == 0) and (H[1] - T[1] == 0)):
                print('no need to move')
            else:
                #check if we need to do a diagonal move or not
                if H[0] != T[0]:
                    if H[1] - T[1] < 0:
                        if H[0] - T[0] < 0:
                            H,T = check_up_left_diag()
                        else:
                            H,T = check_up()
                    elif H[1] - T[1] > 0:
                        if H[0] - T[0] < 0:
                            H,T = check_up_right_diag()
                        else:
                            H,T = check_up()
                    else:
                        print('check up')
                        H,T =check_up()
                else:
                    H,T = check_up()
        elif direction == "D":
            H[0]+=1
            if ((H[0] - T[0] == 1 or H[0] - T[0] == -1) and (H[1] - T[1] == 1 or H[1] - T[1] == -1)) or ((H[0] - T[0] == 0) and (H[1] - T[1] == 1 or H[1] - T[1] == -1)) or ((H[0] - T[0] == 1 or H[0] - T[0] == -1) and (H[1] - T[1] == 0)) or ((H[0] - T[0] == 0) and (H[1] - T[1] == 0)):
                print('no need to move')
            else:
                #check if we need to do a diagonal move or not
                if H[1] != T[1]:
                    if H[1] - T[1] < 0:
                        if H[0] - T[0] > 0:
                            H,T = check_down_left_diag()
                        else:
                            H,T = check_down()
                    elif H[1] - T[1] > 0:
                        if H[0] - T[0] > 0:
                            H,T = check_down_right_diag()
                        else:
                            H,T = check_down()
                    else:
                        H,T = check_down()
                else:
                    H,T = check_down()
                
        visited["row"+str(T[0])+"col"+str(T[1])] = len(visited) +1
        print("H",H, "T", T)
        
        # for i in range(5):
        #     for j in range(6):
        #         if i == H[0] and j == H[1]:
        #             print("H", end="")
        #         elif i == T[0] and j == T[1]:
        #             print("T", end="")
        #         elif i == T[0] and j == T[1] and i == H[0] and j == H[1]:
        #             print("B", end="")
        #         else:
        #             print(".", end="")
        #     print("\n")



print("head", H, "tail", T)
print(len(visited))
print(visited)
print()
print("solution to part 1: ", len(visited))




