class LessonsData {
  static Map<String, List<Map<String, dynamic>>> getSubjectLessons(String subjectName) {
    switch (subjectName) {
      case 'Mathematics':
        return {
          'lessons': [
            {
              'lessonTitle': 'Lesson 1: Algebra Fundamentals',
              'topics': [
                {
                  'title': 'Introduction to Algebra',
                  'content': 'Algebra is a fundamental branch of mathematics that uses letters and symbols to represent numbers and quantities in formulas and equations. In this topic, we\'ll explore:\n\n• Variables and constants\n• Basic algebraic expressions\n• Simple equations\n• Order of operations\n\nAlgebra helps us solve real-world problems by creating mathematical models.',
                },
                {
                  'title': 'Variables and Constants',
                  'content': 'Understanding the difference between variables and constants is crucial in algebra:\n\n• Variables: Symbols that represent unknown values (x, y, z)\n• Constants: Fixed numerical values (5, -3, π)\n• Coefficients: Numbers multiplying variables\n• Terms: Individual parts of expressions\n\nMastering these concepts forms the foundation for algebraic problem-solving.',
                },
                {
                  'title': 'Algebraic Expressions',
                  'content': 'Algebraic expressions combine variables, constants, and operations:\n\n• Simple expressions: 2x + 3\n• Complex expressions: 3x² + 2xy - 5\n• Like terms: Terms with same variables and powers\n• Simplifying expressions\n\nLearning to manipulate expressions is essential for solving equations.',
                },
              ],
            },
            {
              'lessonTitle': 'Lesson 2: Equations and Solutions',
              'topics': [
                {
                  'title': 'Linear Equations',
                  'content': 'Linear equations are equations where the highest power of the variable is 1. They form straight lines when graphed.\n\n• Standard form: ax + b = 0\n• Slope-intercept form: y = mx + b\n• Solving linear equations\n• Applications in real life\n\nLinear equations are used in business, physics, and many other fields.',
                },
                {
                  'title': 'Quadratic Equations',
                  'content': 'Quadratic equations contain variables raised to the second power and form parabolic curves when graphed.\n\n• Standard form: ax² + bx + c = 0\n• Factoring methods\n• Quadratic formula\n• Graphing parabolas\n\nQuadratic equations model many natural phenomena like projectile motion.',
                },
              ],
            },
          ],
        };
      case 'Science':
        return {
          'lessons': [
            {
              'lessonTitle': 'Lesson 1: Matter and Its States',
              'topics': [
                {
                  'title': 'States of Matter',
                  'content': 'Matter exists in different states based on the arrangement and movement of particles.\n\n• Solid: Fixed shape and volume\n• Liquid: Fixed volume, takes container shape\n• Gas: No fixed shape or volume\n• Plasma: Highly energized gas\n\nChanges between states occur with temperature and pressure variations.',
                },
                {
                  'title': 'Particle Theory',
                  'content': 'The particle theory explains the behavior of matter:\n\n• All matter is made of tiny particles\n• Particles are in constant motion\n• Temperature affects particle movement\n• Forces between particles vary\n\nThis theory helps us understand phase changes and material properties.',
                },
              ],
            },
            {
              'lessonTitle': 'Lesson 2: Chemical Changes',
              'topics': [
                {
                  'title': 'Chemical Reactions',
                  'content': 'Chemical reactions involve the rearrangement of atoms to form new substances.\n\n• Reactants and products\n• Types of reactions\n• Conservation of mass\n• Reaction rates\n\nChemical reactions are essential for life processes and industrial applications.',
                },
                {
                  'title': 'Energy in Reactions',
                  'content': 'Energy changes occur during chemical reactions:\n\n• Exothermic reactions: Release energy\n• Endothermic reactions: Absorb energy\n• Activation energy: Energy needed to start reaction\n• Catalysts: Speed up reactions\n\nUnderstanding energy helps predict reaction behavior.',
                },
              ],
            },
          ],
        };
      default:
        return {
          'lessons': [
            {
              'lessonTitle': 'Lesson 1: Introduction to $subjectName',
              'topics': [
                {
                  'title': 'Fundamentals',
                  'content': 'Welcome to the study of $subjectName. This introductory topic covers the fundamental concepts and principles that form the foundation of this subject.\n\n• Key terminology\n• Basic concepts\n• Historical context\n• Real-world applications\n\nUnderstanding these basics will help you progress to more advanced topics.',
                },
                {
                  'title': 'Core Principles',
                  'content': 'This topic explores the core principles and theories that govern $subjectName.\n\n• Fundamental laws\n• Key relationships\n• Problem-solving approaches\n• Practical examples\n\nMastering these principles is essential for advanced study in this field.',
                },
              ],
            },
          ],
        };
    }
  }
}
