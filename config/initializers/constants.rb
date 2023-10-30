COMPLETIONS_MODEL = "gpt-3.5-turbo-instruct"

COMPLETIONS_API_PARAMS = {
    # We use temperature of 0.0 because it gives the most predictable, factual answer.
    "temperature": 0.0,
    "max_tokens": 150,
    "model": COMPLETIONS_MODEL,
}

HEADER = "\"\"The Little Prince is a philosophical tale written by Antoine de Saint-Exupéry. It is one of the most translated books in the world. This set of questions and answers are derived from the key themes of the book. Please keep your answers concise and to the point.\n\nContext that may be useful, pulled from The Little Prince:\n\"\""

MAX_SECTION_LEN = 500

QUESTIONS = [
  {
      question: "Why did the Little Prince leave his asteroid?",
      answer: "The Little Prince left his asteroid, B-612, because he was seeking understanding and answers about life and relationships, particularly after a misunderstanding with a rose that he loved."
  },
  {
      question: "What does the fox mean when he says, 'You become responsible forever for what you’ve tamed'?",
      answer: "The fox suggests that relationships require responsibility. Once you've connected and formed a bond with someone or something, you have an ongoing commitment to care for and cherish that bond."
  },
  {
      question: "Why does the Little Prince find adults puzzling?",
      answer: "The Little Prince finds adults to be narrow-minded and overly concerned with inconsequential matters. They often miss the true essence and beauty of life, focusing on figures and tangible achievements."
  },
  {
      question: "What is the significance of the baobabs on the Little Prince's planet?",
      answer: "Baobabs, if not attended to, can overtake the Little Prince's small planet. They are symbolic of small problems or negative thoughts that can become overwhelming if not addressed early."
  },
  {
      question: "Why is the story of the lamplighter important?",
      answer: "The lamplighter is dedicated to his duty, even if it seems absurd. His story underscores the theme of the repetitive nature of adult lives and the loss of meaningful purpose."
  },
  {
      question: "What lessons does the Little Prince learn from the rose?",
      answer: "The Little Prince learns about the complexities of love, the pain of loneliness, and the importance of relationships. The rose's vanity and pretensions teach him about the nature of love and loss."
  },
  {
      question: "Why is the Little Prince's encounter with the snake significant?",
      answer: "The snake's bite allows the Little Prince to shed his earthly body and return to his asteroid. It's a metaphor for the cyclical nature of life and the transition between life and death."
  },
  {
      question: "How does the pilot change after meeting the Little Prince?",
      answer: "The pilot, through his interactions with the Little Prince, reawakens to the wonders and mysteries of life. He learns to see with his heart and not just his eyes."
  },
  {
      question: "What does the Little Prince teach about relationships?",
      answer: "Relationships are based on mutual understanding, shared experiences, and emotional bonds. They require effort, care, and responsibility but are the source of life's greatest joys."
  },
  {
      question: "How does the story highlight the differences between childlike and adult perspectives?",
      answer: "While adults focus on practicalities and superficialities, children see the deeper truths and beauty in the world. The story encourages readers to maintain a childlike sense of wonder and imagination."
  }
];

SEPARATOR = "\n* "