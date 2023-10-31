import { FormEvent, useEffect, useRef, useState } from 'react'
import styles from './AskAboutThisBook.module.css'
import book from '../static/book.png'

const defaultQuestions = [
  "What is the central message of 'The Little Prince'?",
  "How does the relationship between the Little Prince and the rose evolve throughout the story?",
  "What significance do the various planets the Little Prince visits hold in the narrative?"
]

const getRandomQuestion = () => defaultQuestions[
  Math.floor(Math.random() * defaultQuestions.length)
];

interface Question {
  id: number,
  question: string,
  answer: string,
}
interface Props {
  csrfToken: string;
  focusedQuestion?: Question
}

const AskAboutThisBook = ({
  csrfToken,
  focusedQuestion,
}: Props) => {
  const [initialQuestion, setInitialQuestion] = useState<string>(focusedQuestion?.question ?? "Why did the Little Prince leave his planet?");
  const [answer, setAnswer] = useState<string | null>(focusedQuestion?.answer ?? null);
  const [isRequesting, setIsRequesting] = useState<boolean>(false);
  const [displayedAnswer, setDisplayedAnswer] = useState<string>("");
  const [displayAskAnotherButton, setDisplayAskAnotherButton] = useState<boolean>(false);
  const [charIndex, setCharIndex] = useState(0);
  const [cachedData, setCachedData] = useState<Question[]>([]);

  const formRef = useRef<HTMLFormElement | null>(null);
  const textareaRef = useRef<HTMLTextAreaElement | null>(null);


  const handleLuckyButtonClick = () => {
    setAnswer(null);
    setIsRequesting(false);
    setInitialQuestion(getRandomQuestion());
    
    handleSubmit();
  };
  
  const handleAskAnotherQuestion = () => {
    setDisplayedAnswer(null);
    window.history.replaceState({}, '', '/');
    // Focus the textarea
    textareaRef.current?.focus();
    // Select all text inside the textarea
    textareaRef.current?.select();
  }
  
  const handleSubmit = async (event?: FormEvent<HTMLFormElement>) => {
    if (event) event.preventDefault();

    setAnswer(null);
    setDisplayedAnswer("");
    setCharIndex(0);
    setDisplayAskAnotherButton(false);
    setIsRequesting(true);

    const currentQuestion = formRef.current?.question.value || initialQuestion;
    
    // Check if the answer is cached
    if (cachedData.some((cachedAnswer) => cachedAnswer.question === currentQuestion)) {
      const data = cachedData.find(
        (cachedAnswer) => cachedAnswer.question === currentQuestion
      );
      setAnswer(data?.answer ?? null);
      window.history.pushState({}, '', `/questions/${data.id}`);
      setIsRequesting(false);
      return;
    }
    
    setIsRequesting(true);

    try {
      const response = await fetch('/api/ask', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({ question: currentQuestion }),
      });

      const data = await response.json();
      setAnswer(data.answer);
      setCachedData((prev) => [...prev, data]);
      window.history.pushState({}, '', `/questions/${data.id}`);
    } catch (error) {
      console.error("Error fetching answer:", error);
    } finally {
      setIsRequesting(false);
    }
  };

  
  useEffect(() => {
    let timer: NodeJS.Timeout;
  
    if (answer && charIndex < answer.length) {
      timer = setTimeout(() => {
        setDisplayedAnswer((prev) => prev + answer[charIndex]);
        setCharIndex((prev) => prev + 1);
      }, 50); 
    } else if (charIndex === answer?.length) {
      setDisplayAskAnotherButton(true);
    }
    
    return () => {
      clearTimeout(timer);
    }
      
  }, [charIndex, answer]);
  
  const { header, logo, main, credits, buttons, luckyButton, askAnotherButton } = styles;

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
        <p className={credits}>This is an experiment in using AI to make book's content more accessible. Ask a question and AI'll answer it in real-time:</p>
        <form
          ref={formRef}
          onSubmit={handleSubmit}
        >
          <textarea 
            ref={textareaRef}
            name="question"
            value={initialQuestion}
            onChange={(event) => setInitialQuestion(event.target.value)}
          />
          {displayedAnswer ? 
            <p>
              <strong>Answer:</strong>
              <span>
                {displayedAnswer}
              </span>
              {
                displayAskAnotherButton && 
                  <button
                    className={askAnotherButton} 
                    onClick={handleAskAnotherQuestion}
                  >
                    Ask another question
                  </button>}
            </p>
            :
            <div className={buttons}>
              <button
                type="submit"
                disabled={isRequesting}
              >
                {isRequesting ? "Asking..." : "Ask question"}
              </button>
              <button
                type='button'
                className={luckyButton}
                disabled={isRequesting}
                onClick={handleLuckyButtonClick} 
              >
                I'm feeling lucky
              </button>
            </div>
          }
        </form>
      </div>
      <footer>
        <p className={credits}>Project by <a href="https://twitter.com/meetliby">Bryan Lee</a> • <a href="https://github.com/liby/askmybook">Fork on GitHub</a></p>
        <p className={credits}>This project is Rails and React implementation of <a href="https://github.com/slavingia/askmybook">slavingia/askmybook</a></p>
      </footer>
    </>
  )
}

export default AskAboutThisBook;
