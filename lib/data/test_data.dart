class TestData {
  static List<Map<String, dynamic>> getTestQuestions(String subjectName) {
    switch (subjectName) {
      case 'Mathematics':
        return [
          {
            'question': 'What is a variable in algebra?',
            'options': [
              'A fixed number',
              'A symbol representing an unknown value',
              'An operation',
              'A constant'
            ],
            'correctAnswer': 1,
          },
          {
            'question': 'In the expression 3x + 5, what is the coefficient of x?',
            'options': ['5', '3', 'x', '8'],
            'correctAnswer': 1,
          },
          {
            'question': 'What is the standard form of a linear equation?',
            'options': ['y = mx + b', 'ax + b = 0', 'x² + y = 0', 'a = b + c'],
            'correctAnswer': 1,
          },
        ];
      case 'Science':
        return [
          {
            'question': 'Which state of matter has a fixed shape and volume?',
            'options': ['Liquid', 'Gas', 'Solid', 'Plasma'],
            'correctAnswer': 2,
          },
          {
            'question': 'What happens to particles when temperature increases?',
            'options': [
              'They move slower',
              'They move faster',
              'They stop moving',
              'Nothing changes'
            ],
            'correctAnswer': 1,
          },
          {
            'question': 'In a chemical reaction, what are the starting substances called?',
            'options': ['Products', 'Reactants', 'Elements', 'Compounds'],
            'correctAnswer': 1,
          },
        ];
      default:
        return [
          {
            'question': 'What are the fundamental concepts in $subjectName?',
            'options': [
              'Basic terminology and principles',
              'Advanced theories only',
              'Historical facts only',
              'Practical applications only'
            ],
            'correctAnswer': 0,
          },
          {
            'question': 'Why is understanding core principles important?',
            'options': [
              'For memorization',
              'For advanced study and application',
              'For testing only',
              'Not important'
            ],
            'correctAnswer': 1,
          },
        ];
    }
  }
}
