class PromptManager {
  static String getAssessmentQuizzes(String subject) {
    return '''
Your task is to generate 3 distinct quizzes on the subject of $subject. Each quiz must consist of one question, with multiple answer options.

For each quiz:

- The question field should be a string related to $subject concepts.
- The options field should contain a list of 4 to 6 strings, representing possible answers.
- The correctAnswers field should be a list of integers, where each integer corresponds to the index (0-based) of a correct option from the list.
- The userAnswers field should be an empty list of integers [].
- Ensure that the number of correct answers varies across the quizzes (e.g., one quiz with 1 correct answer, another with 2, and another with 3 correct answers).

Return the output as a List of Maps, where each map represents a quiz. Do not include any formatting tags or code blocks.

Example structure:

[
  {
    "question": "What is the output of the following code: ...?",
    "options": ["Option A", "Option B", "Option C", "Option D"],
    "correctAnswers": [0, 2],
    "userAnswers": []
  },
  {
    "question": "Which of the following are true about Java inheritance?",
    "options": ["Option A", "Option B", "Option C", "Option D", "Option E"],
    "correctAnswers": [1],
    "userAnswers": []
  },
  ...
]

Ensure that the questions, options, correct answers, and the userAnswers field are accurate and relevant to $subject.
''';
  }

  static String getAssessmentEvaluation(String subject, String userQuizzes) {
    return '''
You have been provided with a JSON file containing quiz results from a user who is learning $subject. The JSON structure includes fields such as `question`, `options`, `correctAnswers`, and `userAnswers`. Based on the user's answers, analyze their performance and provide a personalized quote that:

1. Assesses the user's current understanding of $subject based on the questions they answered.
2. Highlights the areas where they demonstrated strong knowledge.
3. Suggests specific topics or concepts they should focus on next to improve their skills.

The JSON input is as follows:

$userQuizzes

Requirements:

- Start by acknowledging the user's current level based on their answers.
- Provide positive reinforcement by mentioning what they have learned or understand well.
- Recommend the next topics they should focus on to continue improving their $subject skills.
- The output should be a single, concise quote or statement, no longer than 3 sentences.
''';
  }

  static String getNewCourse(String subject, String userQuizzes) {
    return '''

''';
  }
}
