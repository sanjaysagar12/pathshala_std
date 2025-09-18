class QuizData {
  static List<Map<String, dynamic>> getQuizQuestions(String subjectName) {
    switch (subjectName) {
      case 'Mathematics':
        return [
          {
            'question': 'What is the result of 15 + 27?',
            'options': ['40', '42', '41', '43'],
            'correctAnswer': 1,
            'explanation': '15 + 27 = 42. This is basic addition.',
          },
          {
            'question': 'If x = 5, what is the value of 2x + 3?',
            'options': ['10', '13', '8', '15'],
            'correctAnswer': 1,
            'explanation': '2(5) + 3 = 10 + 3 = 13',
          },
          {
            'question': 'What is the area of a rectangle with length 8 and width 6?',
            'options': ['14', '28', '48', '64'],
            'correctAnswer': 2,
            'explanation': 'Area = length × width = 8 × 6 = 48 square units',
          },
          {
            'question': 'Which of these is a prime number?',
            'options': ['15', '21', '17', '25'],
            'correctAnswer': 2,
            'explanation': '17 is prime because it can only be divided by 1 and itself.',
          },
          {
            'question': 'What is 25% of 80?',
            'options': ['15', '20', '25', '30'],
            'correctAnswer': 1,
            'explanation': '25% of 80 = (25/100) × 80 = 20',
          },
        ];
      case 'Science':
        return [
          {
            'question': 'What is the chemical symbol for water?',
            'options': ['H2O', 'CO2', 'NaCl', 'O2'],
            'correctAnswer': 0,
            'explanation': 'Water is composed of 2 hydrogen atoms and 1 oxygen atom: H2O',
          },
          {
            'question': 'Which planet is closest to the Sun?',
            'options': ['Venus', 'Mercury', 'Earth', 'Mars'],
            'correctAnswer': 1,
            'explanation': 'Mercury is the innermost planet in our solar system.',
          },
          {
            'question': 'What force pulls objects toward Earth?',
            'options': ['Magnetism', 'Friction', 'Gravity', 'Pressure'],
            'correctAnswer': 2,
            'explanation': 'Gravity is the force that attracts objects toward the center of Earth.',
          },
          {
            'question': 'At what temperature does water freeze?',
            'options': ['0°C', '32°C', '100°C', '-10°C'],
            'correctAnswer': 0,
            'explanation': 'Water freezes at 0°C (32°F) under normal atmospheric pressure.',
          },
          {
            'question': 'Which gas do plants absorb from the air?',
            'options': ['Oxygen', 'Nitrogen', 'Carbon dioxide', 'Hydrogen'],
            'correctAnswer': 2,
            'explanation': 'Plants absorb CO2 from the air during photosynthesis.',
          },
        ];
      case 'English':
        return [
          {
            'question': 'Which word is a noun?',
            'options': ['Run', 'Beautiful', 'House', 'Quickly'],
            'correctAnswer': 2,
            'explanation': 'House is a noun - it names a place or thing.',
          },
          {
            'question': 'What is the past tense of "go"?',
            'options': ['Gone', 'Going', 'Went', 'Goes'],
            'correctAnswer': 2,
            'explanation': 'The past tense of "go" is "went".',
          },
          {
            'question': 'Which sentence is correct?',
            'options': [
              'I are happy',
              'I is happy', 
              'I am happy',
              'I be happy'
            ],
            'correctAnswer': 2,
            'explanation': 'The correct form is "I am happy" - using the correct verb form.',
          },
          {
            'question': 'What type of word is "slowly"?',
            'options': ['Noun', 'Verb', 'Adjective', 'Adverb'],
            'correctAnswer': 3,
            'explanation': 'Slowly is an adverb - it describes how an action is performed.',
          },
          {
            'question': 'Which punctuation mark ends a question?',
            'options': ['.', '!', '?', ','],
            'correctAnswer': 2,
            'explanation': 'Questions end with a question mark (?).',
          },
        ];
      default:
        return [
          {
            'question': 'What is a fundamental concept in $subjectName?',
            'options': [
              'Basic principles and theories',
              'Advanced applications only',
              'Historical facts only',
              'Memorization techniques'
            ],
            'correctAnswer': 0,
            'explanation': 'Fundamental concepts include basic principles and theories that form the foundation.',
          },
          {
            'question': 'How should you approach learning $subjectName?',
            'options': [
              'Only through memorization',
              'Understanding concepts and practice',
              'Reading once is enough',
              'Avoiding difficult topics'
            ],
            'correctAnswer': 1,
            'explanation': 'Effective learning combines understanding concepts with regular practice.',
          },
          {
            'question': 'What helps in mastering $subjectName?',
            'options': [
              'Skipping practice',
              'Regular study and application',
              'Only theoretical knowledge',
              'Avoiding questions'
            ],
            'correctAnswer': 1,
            'explanation': 'Regular study and practical application help in mastering any subject.',
          },
        ];
    }
  }
}
