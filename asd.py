#1
l = [1,1,2,1,3,3,4,2,4,5,5,4,5,2,3,4,5,6,7,78]
l.sort()
print(l)
for i in l:
     while l.count(i)!=1:
          l.pop(i)

print(l)
#2
l = [1,1,2,1,3,3,4,2,4,5,5]
e = input('Enter a element to input')
p = int(input('enter the position'))

def insert():
     l.insert(p,e)
     print(l)


#3a
l = [1,1,2,1,3,3,4,2,4,5,5]
d =int(input('enter the position to del'))
while d >= len(l):
     d =int(input('enter the position to del less than the size of list'))

e = str(input('enter the element to del'))
print(type(e))
if e.isdigit():
     e =int(e)
while e not in l:
     e = input('enter the element to del again')
     if e.isdigit():
          e =int(e) 


def dele():
     l.pop(d)
     print(l)
     l.remove(e)

#4
n = int(input('enter the no. element '))
l = []
def rev():
     for i in range(n):
          x = input('enter element')
          l.append(x)

     print(l)
     l.reverse()
     print(l)
rev()

#5
e = ()
u=()
d=()
n = int(input('enter the no. emails'))
for i in range(n):
    x = input('Enter')
    e+=(x,)
    x = tuple(x.split('@'))
    u+=(x[0],)
    d+=(x[1],)
print(e)
print(u)
print(d)
#6
def lcount(s):
    count_dict = {}
    for char in s:
        if char.isalpha():
            char_lower = char.lower()
            count_dict[char_lower] = count_dict.get(char_lower, 0) + 1
    return count_dict

input_str = input("Enter a string: ")
result_dict = lcount(input_str)
print("Letter count dictionary:", result_dict)

#7

n = int(input("Enter how many names you want to enter: "))
names = {}

def check(d):
    while d not in names:
        d = input(f"{d} not found. Enter again: ")
    return d

for _ in range(n):
    name, number = input("Enter name of friend: "), input("Enter phone number: ")
    names[name] = number

print(names)

names[input('Enter new name: ')] = input('Enter new number: ')
print(names)

to_delete = check(input('Enter name to delete: '))
del names[to_delete]

to_modify = check(input('Enter name to change: '))
names[to_modify] = input('Enter new number: ')

to_check = input('Enter name to check: ')
print(to_check in names)

print("Dictionary in sorted order")
for i in sorted(names):
    print((i, names[i]), end=" ")

