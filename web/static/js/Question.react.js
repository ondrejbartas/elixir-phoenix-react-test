import React, { Component, PropTypes as RPT } from 'react';

export default class Question extends Component {
  static contextTypes = {
    store: RPT.object.isRequired
  }

  static propTypes = {
    id: RPT.number,
    text: RPT.string,
    upVote: RPT.func,
    likes: RPT.object,
    likesCount: RPT.number,
    isLoggedIn: RPT.bool
  }

  upVote() {
    const { store: { dispatch, getState } } = this.context;
    const { id: questionId } = this.props;
    const userId = getState().getIn(['user', 'id']);

    dispatch({ type: 'UP_VOTE', questionId, userId });

    fetch('/api/likes', {
      method: 'post',
      body: JSON.stringify({ like: { user_id: userId, question_id: questionId } }),
      headers: {
        'Content-Type': 'application/json'
      }
    })
      .then(r => r.json())
      .then(({ data }) => {
        dispatch({ type: 'LIKE_CREATED', payload: data });
        dispatch({ type: 'UPDATE_QUESTION', payload: data.question });
      });
  }

  alreadyVoted() {
    const { store: { getState } } = this.context;
    const { likes } = this.props;
    const userId = getState().getIn(['user', 'id']);
    return !!likes.find(i => i.get('user_id') === userId);
  }

  render() {
    const { text, isLoggedIn, likesCount, likes } = this.props;

    return (
      <div>
        {text}
        <div style={{ color: 'green' }}>{likesCount}</div>
        <button disabled={!isLoggedIn || this.alreadyVoted()} onClick={this.upVote.bind(this)}> Like + 1</button>
        {likes.map(l =>
          <img
            src={`https://twitter.com/${l.get('user_name')}/profile_image?size=mini`}
            key={l.get('user_id')}
            alt={l.get('user_name')}
          />)}
      </div>
    );
  }
}
