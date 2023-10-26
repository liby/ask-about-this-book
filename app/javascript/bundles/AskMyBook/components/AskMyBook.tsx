import { useState } from 'react'
import styles from './AskMyBook.module.css'
import book from '../static/book.png'

const options = [
  "What is a minimalist entrepreneur?",
  "What is your definition of community?",
  "How do I decide what kind of business I should start?"
]

const getRandomQuestion = () => options[Math.floor(Math.random() * options.length)];

const AskMyBook = () => {
  const [randomQuestion, setRandomQuestion] = useState("What is The Minimalist Entrepreneur about?");

  const handleLuckyButtonClick = () => {
    setRandomQuestion(getRandomQuestion());
  }

  const { header, logo, main, credits, buttons, luckyButton, hidden, askAnotherButton } = styles;

  return (
    <>
      <div className={header}>
        <div className={logo}>
          <a href="https://www.amazon.com/Minimalist-Entrepreneur-Great-Founders-More/dp/0593192397">
            <img src={book} alt="The Minimalist Entrepreneur: How Great Founders Do More with Less" loading="lazy" />
          </a>
          <h1>Ask My Book</h1>
        </div>
      </div>
      <div className={main}>
        <p className={credits} xt-marked="ok">This is an experiment in using AI to make my book's content more accessible. Ask a question and AI'll answer it in real-time:</p>
        <form action="/ask" method="post">
          <textarea name="question" id="question" defaultValue={randomQuestion} />
          <div className={buttons}>
            <button type="submit" id="ask-button" xt-marked="ok">Ask question</button>
            <button type='button' id="lucky-button" xt-marked="ok" className={luckyButton} onClick={handleLuckyButtonClick}>I'm feeling lucky</button>
          </div>
        </form>
        <p id="answer-container" className={hidden}>
          <strong xt-marked="ok">Answer:</strong>
          <span id="answer"></span>
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

export default AskMyBook;
