import React, { Component, PropTypes as RPT } from 'react';
import Talk from './Talk.react';
import User from './User.react';
import { connect } from 'react-redux';

class App extends Component {
  static propTypes = {
    talks: RPT.object,
    user: RPT.object,
    newQuestions: RPT.object
  }

  render() {
    const { talks, user, newQuestions } = this.props;
    const isLoggedIn = !!user.get('id');

    return (
      <div>
        <h1>Questhor 22 {isLoggedIn}</h1>
        {!isLoggedIn && <User name={user.get('name')} />}
        {isLoggedIn && <span>Logged in as {user.get('name')}</span>}
        {isLoggedIn && talks.map((talk) =>
          <Talk
            key={talk.get('name')}
            talkId={talk.get('id')}
            name={talk.get('name')}
            newQuestionText={newQuestions.get(String(talk.get('id')))}
            questions={talk.get('questions')}
          />)}
      </div>
    );
  }
}


export default connect(
  state => ({
    talks: state.get('talks'),
    user: state.get('user'),
    newQuestions: state.get('newQuestions')
  })
)(App);
