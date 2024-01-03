import random

class Quiz:
    def __init__(self):
        self.questions = {}  # Dictionary to store questions and answers
        self.categories = []  # List to store available categories
        self.scores = {}  # Dictionary to store participant scores
        self.current_user = None

    def add_question(self, category, question, options, correct_option):
        if category not in self.categories:
            self.categories.append(category)
            self.questions[category] = []
        self.questions[category].append({
            'question': question,
            'options': options,
            'correct_option': correct_option
        })

    def register_user(self, username, password):
        self.current_user = {'username': username, 'password': password, 'score': 0}
        self.scores[username] = 0

    def login(self, username, password):
        if username in self.scores and self.scores[username]['password'] == password:
            self.current_user = self.scores[username]
            return True
        else:
            return False

    def play_quiz(self, category):
        if category not in self.categories:
            print("Invalid category.")
            return

        questions = self.questions[category]
        random.shuffle(questions)

        for q in questions:
            print("\n", q['question'])
            for i, option in enumerate(q['options'], 1):
                print(f"{i}. {option}")

            user_answer = int(input("Your choice (1-{}): ".format(len(q['options']))))

            if user_answer == q['correct_option']:
                self.current_user['score'] += 1

        print("\nQuiz Completed!\nYour Final Score: {}/{}".format(
            self.current_user['score'], len(questions)))

    def display_categories(self):
        print("\nAvailable Categories:")
        for i, category in enumerate(self.categories, 1):
            print(f"{i}. {category}")

    def display_final_score(self):
        if self.current_user:
            print("\nFinal Score for {}: {}/{}".format(
                self.current_user['username'], self.current_user['score'], len(self.questions)))


# Example Usage:

quiz_program = Quiz()

# Admin adds questions
quiz_program.add_question("Math", "What is 2 + 2?", ["3", "4", "5", "6"], 2)
quiz_program.add_question("Science", "What is the capital of France?", ["Paris", "Berlin", "Rome", "Madrid"], 1)

# Admin creates a user
quiz_program.register_user("JohnDoe", "password")

# User logs in
if quiz_program.login("JohnDoe", "password"):
    # User selects a category
    quiz_program.display_categories()
    selected_category = int(input("Select a category (1-{}): ".format(len(quiz_program.categories))))
    selected_category = quiz_program.categories[selected_category - 1]

    # User plays the quiz
    quiz_program.play_quiz(selected_category)

    # Display final score
    quiz_program.display_final_score()
else:
    print("Login failed. Invalid username or password.")
