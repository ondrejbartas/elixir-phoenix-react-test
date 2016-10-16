import React from 'react';
import Question from './Question.react';
import { Map } from 'immutable';

export default ({ name, questions }) => (
  <div>
    <h2>{name}</h2>
    {
      (questions || Map())
        .valueSeq()
        .sortBy(q => q.get('likes'))
        .reverse()
        .map(q => <Question key={q.get('id')} text={q.get('text')} likes={q.get('likes')} />)
        .toArray()
    }
  </div>
)
