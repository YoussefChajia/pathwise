class PromptManager {
  static String getAssessmentQuizzes(String subject) {
    return '''
Your task is to generate 20 distinct quizzes on the subject of $subject. Each quiz must consist of one question, with multiple answer options.

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

  static String generateCourse(String subject, String userQuizzes) {
    return '''
You are an expert instructor in $subject with extensive experience in creating tailored learning programs. Your task is to design a personalized course for a student who has just completed an assessment in $subject. Below, you will find the student's assessment results.

Here is the student's assessment results:

$userQuizzes

Now generate a clear and organized course as a JSON object with the following structure:

evaluation: Provide a summary that is less then 20 words of the user’s current knowledge based on the quiz results, including areas of strength and topics needing improvement.
title: Title of the course based on the subject.
color: Generate a random 32-bit integer for the course theme color.
progress: The overall progress of the course, starting at 0.0.
isCompleted: A boolean value indicating whether the course has been completed, starting at false.
description: A brief overview of what the user will learn in the course and how is it going to help.
estimatedDuration: Calculate the full estimation the total time required to complete the course in minutes, based on the duration of each module and lesson.
modules: Create at least 10 modules, each focusing on a different aspect of the subject and targets the user’s weaknesses and build upon their strengths.

module.title: The title of the module.
module.description: A brief description of the module.
module.progress: The progress of the module, starting at 0.0.
module.isCompleted: A boolean indicating whether the module is completed, starting at false.
module.estimatedDuration: The estimated time, in minutes, to complete the module.
module.lessons: Each module should contain at least 5 lessons, with in depth content provided in Markdown format. 

lesson.title: The title of the lesson.
lesson.description: A brief description of the lesson.
lesson.progress: The progress of the lesson, starting at 0.0.
lesson.isCompleted: A boolean indicating whether the lesson is completed, starting at false.
lesson.content: In depth content about the lesson ensuring that the student fully understands the concepts of the lesson. Ensure that the content is in Markdown format.
lesson.estimatedDuration: The estimated time, in minutes, to complete the lesson.
''';
  }
}
