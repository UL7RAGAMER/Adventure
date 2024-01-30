def spacer(n):
    print(n,':')
    print()
    print()



my_dict = {'a': 1, 'b': 2, 'c': 3}
# Set d[key] to value
my_dict['d'] = 4
print(my_dict)  # Output: {'a': 1, 'b': 2, 'c': 3, 'd': 4}

spacer(1)

my_dict = {'a': 1, 'b': 2, 'c': 3}
# Remove d[key] from d
del my_dict['a']
print(my_dict)  # Output: {'b': 2, 'c': 3, 'd': 4}

spacer(2)

my_dict = {'a': 1, 'b': 2, 'c': 3}
# Check if key is in d
print('b' in my_dict)  # Output: True

# Equivalent to not key in d
print('e' not in my_dict)  # Output: True

spacer(3)

# Creating a list
my_dict = {'a': 1, 'b': 2, 'c': 3}

# Creating an iterator object from the list using iter()
my_iterator = iter(my_dict)

# Using the iterator to iterate over the elements
while True:
    try:
        # Get the next element from the iterator using next()
        element = next(my_iterator)
        print(element)
    except StopIteration:
        # Stop iteration when there are no more elements
        break

spacer(4)

my_dict = {'a': 1, 'b': 2, 'c': 3}

# Remove all items from the dictionary
my_dict.clear()
print(my_dict)  # Output: {}

spacer(5)

my_dict = {'a': 1, 'b': 2, 'c': 3}


# Return a shallow copy of the dictionary
original_dict = {'a': 1, 'b': 2, 'c': 3}
copy_dict = original_dict.copy()
print(copy_dict)  # Output: {'a': 1, 'b': 2, 'c': 3}

spacer(6)

my_dict = {'a': 1, 'b': 2, 'c': 3}


# Return the value for key if key is in the dictionary, else default
value = my_dict.get('b', 0)
print(value)  # Output: 0

spacer(7)

my_dict = {'a': 1, 'b': 2, 'c': 3}


# Return a new view of the dictionary's items
items_view = my_dict.items()
print(items_view)  # Output: dict_items([('a', 1), ('b', 2), ('c', 3)])

# Return a new view of the dictionary's keys
keys_view = my_dict.keys()
print(keys_view)  # Output: dict_keys(['a', 'b', 'c'])

spacer(8)

my_dict = {'a': 1, 'b': 2, 'c': 3}

# If key is in the dictionary, remove it and return its value, else return default
popped_value = my_dict.pop('b', 0)
print(popped_value)  # Output: 2
print(my_dict)  # Output: {'a': 1, 'c': 3}

# Remove and return a (key, value) pair from the dictionary in LIFO order
pop_item = my_dict.popitem()
print(pop_item)  # Output: ('c', 3)
print(my_dict)  # Output: {'a': 1}

spacer(9)
    
# Creating list 1
d = {'one': 1, 'two': 2, 'three': 3}
# Creating list 2 with slightly diffeerent values
x =  {'three': 3 + 1, 'four': 4+1, 'five': 5 + 1}  
#Create a new dictionary and take the 2nd dictionary as proirity
y =  d | x
print(y)#output = {'one': 1, 'two': 2, 'three': 4, 'four': 5, 'five': 6}
#Does same but Updates Dictionary
d |= x
print(d)

spacer(10)

my_dict = {'a': 1, 'b': 2, 'c': 3}

# Return a reverse iterator over the keys of the dictionary
reversed_iterator = reversed(my_dict)
for key in reversed_iterator:
    print(key)
# Output: 'c', 'b', 'a'

# If key is in the dictionary, return its value; otherwise, insert key with a value of default and return default
value = my_dict.setdefault('d', 4)
print(value)  # Output: 4
print(my_dict)  # Output: {'a': 1, 'b': 2, 'c': 3, 'd': 4}

spacer(11)

# Update the dictionary with key/value pairs from another dictionary
other_dict = {'e': 5, 'f': 6}
my_dict.update(other_dict)
print(my_dict)  # Output: {'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5, 'f': 6}


spacer(12)

my_dict = {'a': 1, 'b': 2, 'c': 3}
# Return a new view of the dictionary's values
values_view = my_dict.values()
print(values_view)  # Output: dict_values([1, 2, 3, 4, 5, 6, 7, 8])

# Example illustrating the note about equality comparison for dict.values() views
values_view_2 = my_dict.values()
print(values_view == values_view_2)  # Output: False

import os
user_name = 'admin07'
user_pass = 'admin123'
answers_dict = {}
d = {}

def admin_login():
    print(' ')
    print("Please login with Valid Administrator User name and Password")
    print(' ')
    while True:
        admin_user = input("Enter the username: ")
        admin_pass = input("Enter the password: ")
        if admin_user == user_name and admin_pass == user_pass:
            print("Welcome! admin07")
            break
        else:
            print("Invalid username or password please try again")
admin_login()

def admin_questions():
    qu = int(input("Enter the number of categories you want: "))
    for i in range(qu):
        c = input("Enter the name of the category: ")
        e = int(input(f"Enter the number of questions for {c} category: "))
        questions = []
        answers = []  
        for j in range(e):
            f = input("Enter the question: ")
            questions.append(f)
            ans = input(f"Enter the answer for '{f}': ")
            answers.append(ans)
        d[c] = questions
        answers_dict[c] = dict(zip(questions, answers))  
    print(d)
    print(answers_dict)

admin_questions()

def modify_questions():
    mu = input("Enter the category of questions you want to modify: ")
    if mu in d:
        print(f"Questions in '{mu}' category: {d[mu]}")
        choice = input("Do you want to (A)dd or (R)emove a question? (A/R): ").upper()
        if choice == "A":
            f = input("Enter the question: ")
            ans = input(f"Enter the answer for '{f}': ")
            d[mu] += (f)
            answers_dict[mu][f] = ans
            
        elif choice == "R":
            print(f"Current questions: {d[mu]}")
            question_to_remove = input("Enter the question to remove: ")
            if question_to_remove in d[mu]:
                d[mu].remove(question_to_remove)
                print("Question removed successfully!")
            else:
                print("Question not found in the category.")
        else:
            print("Invalid choice.")
    else:
        print("Category not found.")
modify_questions()

def registration():
    u_r = input("Enter the name of the player playing: ")
    print("")
    print('Welcome,', u_r, '! The rules of the game are simple:')
    print("")
    print('You get to choose a category of questions you would want to proceed with.')
    print(" ")
    print('Try to answer these questions to increase your score by 1 point for each correct answer.')
    print("")
    print("If not attempted or wrong answer, there are no negative markings.")
    print(' ')
    print("Available categories are: ", list(d.keys()))
    print('')
    cat = input("Enter the category of the questions you want to attempt: ")
    if cat in d:
        print(f"You've chosen '{cat}' category. Let's start the game!")
        questions = d[cat]
        score = 0
        for idx, question in enumerate(questions, start=1):
            print(f"Question {idx}: {question}")
            user_answer = input("Your answer: ")
            actual_answer = answers_dict[cat].get(question)
            if user_answer.lower() == actual_answer.lower():
                print("Correct!")
                score += 1
            else:
                print(f"Wrong! The correct answer is: {actual_answer}")

        print(f"Game Over! Your final score is: {score}")
    else:
        print("Category not found.")

registration()
