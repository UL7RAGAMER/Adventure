

'''
--*--
-*-*-
*---*
-*-*-
--*--
'''
def hollow_diamond(x):
    spaces = int((x+1)//2)
    int_space = 0
    for i in range(spaces-1,-1,-1):
        for j in range(i):
            print(' ', end="")
        print('*' ,end='')
        print( ' ' * int_space,end='')
        if int_space != 0:
            print('*')
        else:
            print()
        if int_space==0:
            int_space=1
        else:    
            int_space+=2
    int_space-=2
    for i in range(1,spaces):
        for j in range(i):
            print(' ',end='')
        int_space-=2
        print('*', end='')
        if int_space<=0:
            int_space=0
        print(' ' * int_space, end='')
        if int_space != 0:
            print('*')
        else:
            print()

          
'''
*
* *
*   *
*     *
*   *
* *
*
'''

def hollow_triangle(x):

    if x%2 == 0:
        x+=1
    v = (x+1)//2
    sp = 0
    for i in range(v):
        
        print('*', end='')
        print(' '* sp,end='')       
        if sp !=0:
            print('*')
        else:
            print()
        if sp ==0:
            sp = 1
        else:
            sp+=2
    sp-=2      
    for i in range(x-v):
        print("*",end='')
        sp-=2
        if sp <=0:
            sp = 0
        print(' '* sp,end='')
        if sp !=0:
            print('*')
        else:
            print()
def test(x):
    import string

    # Create a list containing all the alphabets
    l = list(string.ascii_uppercase)
    for i in range(x+1):
        for j in range(i):
            print(l[j],' ',end='')
            
        print()
        
    for i in range(x):
        for j in range(i):
            print(l[i],' ',end='')
        print()


l=[21,234,456,567,56,153,407]
alist=[]
for j in l:
    y=str(j)
    s=0
    for i in y:
        i=int(i)
        s+=i*i*i
    if s==j:
        alist.append(s)
        
print(alist)
    
r,m =(1,2)
import json

print(json.dumps(l,indent=1))