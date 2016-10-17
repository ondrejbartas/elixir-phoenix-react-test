// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
// import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

import React from 'react'
import ReactDOM from 'react-dom'
import App from './App.react'

import { createStore } from 'redux'
import { Provider } from 'react-redux'
import { fromJS } from 'immutable'

const formatQuestions = (questions) => (
  questions.reduce(
    (acc, q) => ({ ...acc, [String(q.id)]: q}),
    {}
  )
)

const reducer = (state = {}, action) => {
  console.log(state)
  console.log(action)
  if (action.type === 'UPDATE_QUESTION')
    return state.setIn(['talks', String(action.payload.talk_id), 'questions', String(action.payload.id)], fromJS(action.payload))

  if (action.type === 'DATA_RELOD')
    return action.payload.reduce(
      (acc, { id, questions, ...rest }) =>
        acc.setIn(['talks', String(id)], fromJS({ id, questions: formatQuestions(questions), ...rest })),
      state
    )

  return state
}

const store = createStore(reducer, fromJS({
  talks: {
    // '1': {
    //   name: 'Super duper',
    //   questions: {
    //     '1': {id: 1, text: 'What', likes: 2}
    //   }
    // },
    // '2': {
    //   name: 'Dakooo',
    //   questions: {
    //     '2': {id: 2, text: 'heel1', likes: 5},
    //     '3': {id: 3, text: 'heel2', likes: 10},
    //     '4': {id: 4, text: 'heel3', likes: 8},
    //   }
    // },
    // '3': {
    //   name: 'Super Duperrrr',
    //   questions: {}
    // }
  }
}))

let channel = socket.channel("question:lobby", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully Questions:lobby", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("change", question => {
  console.log('Dispatching', question)
  store.dispatch(question)
})


fetch('/api/talks')
  .then(r => r.json())
  .then(({ data: payload }) => store.dispatch({type: 'DATA_RELOD', payload}))

ReactDOM.render(
  <Provider store={store}><App /></Provider>,
  document.getElementById('react-app')
)
