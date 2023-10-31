import ReactOnRails from 'react-on-rails'
import AskAboutThisBook from '../bundles/AskAboutThisBook/components/AskAboutThisBookServer'
import DbPage from '../bundles/AskAboutThisBook/components/DbPageServer'

// This is how react_on_rails can see the AskAboutThisBook in the browser.
ReactOnRails.register({
  AskAboutThisBook,
  DbPage
})
