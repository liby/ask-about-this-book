import { useState } from 'react'
import styles from './AskAboutThisBook.module.css'
import book from '../static/book.png'

const options = [
  "What is the central message of 'The Little Prince'?",
  "How does the relationship between the Little Prince and the rose evolve throughout the story?",
  "What significance do the various planets the Little Prince visits hold in the narrative?"
]

const getRandomQuestion = () => options[Math.floor(Math.random() * options.length)];

interface Props {
  csrfToken: string;
}

const AskAboutThisBook = ({
  csrfToken
}: Props) => {
  const [randomQuestion, setRandomQuestion] = useState("Why did the Little Prince leave his planet?");
  const [answer, setAnswer] = useState("");
  const [isAnswerHidden, setIsAnswerHidden] = useState(true);

  const handleLuckyButtonClick = () => {
    setRandomQuestion(getRandomQuestion());
  }

  const handleSubmit = async (e) => {
    e.preventDefault();
    const formData = new FormData(e.target);
    const question = formData.get('question');
  
    const response = await fetch('/api/ask', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ question }),
    });
  
    const data = await response.json();
    setAnswer(data.answer);
    setIsAnswerHidden(false);
  };
  

  const { header, logo, main, credits, buttons, luckyButton, hidden, askAnotherButton } = styles;

  return (
    <>
      <div className={header}>
        <div className={logo}>
          <a href="https://a.co/d/auUaQxl">
            <img src={book} alt="The Minimalist Entrepreneur: How Great Founders Do More with Less" loading="lazy" />
          </a>
          <h1>Ask About This Book</h1>
        </div>
      </div>
      <div className={main}>
        <p className={credits} xt-marked="ok">This is an experiment in using AI to make book's content more accessible. Ask a question and AI'll answer it in real-time:</p>
        <form action="/ask" method="post" onSubmit={handleSubmit}>
          <textarea name="question" id="question" defaultValue={randomQuestion} />
          <div className={buttons}>
            <button type="submit" id="ask-button" xt-marked="ok">Ask question</button>
            <button type='button' id="lucky-button" xt-marked="ok" className={luckyButton} onClick={handleLuckyButtonClick}>I'm feeling lucky</button>
          </div>
        </form>
        <p className={isAnswerHidden && hidden}>
          <strong xt-marked="ok">Answer:</strong>
          <span>
            {answer}
          </span>
          <button id="ask-another-button" className={askAnotherButton} xt-marked="ok">Ask another question</button>
        </p>
      </div>
      <footer>
        <p className={credits} xt-marked="ok">Project by <a href="https://twitter.com/meetliby" xt-marked="ok">Bryan Lee</a> • <a href="https://github.com/liby/askmybook" xt-marked="ok">Fork on GitHub</a></p>
        <p className={credits}>This project is Rails and React implementation of <a href="https://github.com/slavingia/askmybook" xt-marked="ok">slavingia/askmybook</a></p>
      </footer>
    </>
  )
}

export default AskAboutThisBook;
