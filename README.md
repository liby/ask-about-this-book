# Ask About This Book

![Screenshot](https://user-images.githubusercontent.com/38807139/279266434-9fd9560e-cc9b-449c-b86d-b9d52bd15740.png)


## Architectural Decisions

- Using [react_on_rails](https://github.com/shakacode/react_on_rails): This makes integrating React into Rails projects simple.
- [Script processes PDFs into vector representations](https://github.com/liby/ask-about-this-book/blob/master/scripts/pdf_to_vector_processor.rb), storing results in a single JSON file for efficient search.
- Utilized [ruby-openai](https://github.com/alexrudall/ruby-openai) gem to streamline interactions with OpenAI API.
- Implemented frontend caching to reduce API calls, enhancing responsiveness.
- Integrated Trestle Authentication to provide a robust and streamlined authentication system for the admin interface.

## Areas for Improvement

- Currently, there's a noticeable flicker every time the page is refreshed. This aspect needs optimization.
- Consider using CSS-in-JS solutions or Tailwind CSS, which can provide more dynamic and componentized styles.
- Plan to replace the current frontend-simulated API streaming with genuine Rails-based server-side streaming.
- Introduce unit and integration tests for both client and server sides to uphold coding standards and identify potential pitfalls.

## Getting Started

1. Clone the repository and Install dependencies
   ```sh
   git clone git@github.com:liby/ask-about-this-book.git
   cd ask-about-this-book
   bundle install
   yarn install
   ```

2. Create and fill in _.env_ using _.env.example_ as an example.

3. Set up database tables 
   ```sh
   rails db:create
   rails db:migrate
   ```

5. Launch both the Rails and React servers by running the command: `bin/dev`.

6. Open your browser and navigate to http://localhost:3000 to access the application.


## About

This project is Rails and React implementation of [slavingia/askmybook](https://github.com/slavingia/askmybook). Co-completed by [Bryan](https://github.com/liby) and ChatGPT.
