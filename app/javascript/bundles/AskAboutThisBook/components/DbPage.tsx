import styles from './AskAboutThisBook.module.css'

interface Props {
  answeredQuestionsCount: number;
  questions: Question[];
}

interface Question {
  id: number,
  question: string,
  answer: string,
  ask_count: number,
}

function DbPage({
  answeredQuestionsCount,
  questions,
}: Props) {

  const { queue } = styles;
  return (
    <div>
      <h2>{answeredQuestionsCount}/500 questions answered</h2>

      <ul className={queue}>
        {questions.map((question) => (
          <li key={question.id}>
            <strong>{question.question}</strong>
            <p>{question.answer}</p>

            <p><small>Asked {question.ask_count} times</small></p>
          </li>
        ))}
      </ul>    </div>
  );
}

export default DbPage;
