
# Program to multiply two matrices using list comprehension
 
# take a 3x3 matrix
A = [[-1, 1, 2],
    [1, 2, 3],
    [3, 1, 1]]
 
# take a 3x4 matrix
B = [[1, -1, 1],
    [-8, 7, -5],
    [5, -4, 3 ]]
 
# result will be 3x4
result = [[sum(a * b for a, b in zip(A_row, B_col)) 
                        for B_col in zip(*B)]
                                for A_row in A]
 
for r in result:
    print(r)