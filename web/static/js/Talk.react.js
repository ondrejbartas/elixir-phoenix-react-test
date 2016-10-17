import React, { Component, PropTypes as RPT } from 'react';
import Question from './Question.react';
import { Map } from 'immutable';
import FlipMove from 'react-flip-move';
import NewQuestion from './NewQuestion.react';

export default class Talk extends Component {

  static propTypes = {
    name: RPT.string,
    talkId: RPT.number,
    questions: RPT.object,
    newQuestionText: RPT.string,
    isLoggedIn: RPT.bool
  }

  renderQ(q) {
    const { isLoggedIn } = this.props;
    return (
      <Question isLoggedIn={isLoggedIn} question={q} key={q.get('id')} id={q.get('id')} text={q.get('text')} likes={q.get('likes')} likesCount={q.get('likesCount')} />
    );
  }

  render() {
    const { name, isLoggedIn, questions, talkId, newQuestionText } = this.props;

    return (
      <div>
        <h2>{name}</h2>
        {isLoggedIn && <NewQuestion talkId={talkId} text={newQuestionText} />}
        <FlipMove>
          {
            (questions || Map())
              .valueSeq()
              .sortBy(q => q.get('likesCount'))
              .reverse()
              .map(q => this.renderQ(q))
          }
        </FlipMove>
      </div>
    );
  }
}
