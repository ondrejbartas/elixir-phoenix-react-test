import React, { Component } from 'react';
import Question from './Question.react';
import { Map } from 'immutable';
import FlipMove from 'react-flip-move';

export default class Talk extends Component {
  renderQ(q) {
    console.log('tip', q.get('likes'))
    return (
      <Question question={q} key={q.get('id')} text={q.get('text')} likes={q.get('likes')} />
    )
  }

  render() {
    const { name, questions } = this.props;

    return (
      <div>
        <h2>{name}</h2>
        <FlipMove>
          {
            (questions || Map())
              .valueSeq()
              .sortBy(q => q.get('likes'))
              .reverse()
              .map(q => this.renderQ(q))
          }
        </FlipMove>
      </div>
    )
  }
}
