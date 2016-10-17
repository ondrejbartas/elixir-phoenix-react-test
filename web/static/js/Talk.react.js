import React, { Component, PropTypes as RPT } from 'react';
import Question from './Question.react';
import { Map } from 'immutable';
import FlipMove from 'react-flip-move';

export default class Talk extends Component {

  static propTypes = {
    name: RPT.string,
    questions: RPT.object
  }

  renderQ(q) {
    return (
      <Question question={q} key={q.get('id')} text={q.get('text')} likes={q.get('likes')} />
    );
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
    );
  }
}
