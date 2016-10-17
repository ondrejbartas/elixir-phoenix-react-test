import React, { Component, PropTypes as RPT } from 'react';
import fetch from 'isomorphic-fetch';

export default class NewQuestion extends Component {
  static contextTypes = {
    store: RPT.object.isRequired
  }

  static propTypes = {
    text: RPT.string,
    talkId: RPT.number,
  }

  changeText({ target: { value } }) {
    const { store: { dispatch } } = this.context;
    const { talkId } = this.props;

    dispatch({
      type: 'CHANGE_QUESTION_TEXT',
      talkId,
      value
    });
  }

  signIn(e) {
    e.preventDefault();
    const { store: { dispatch } } = this.context;
    const { text, talkId } = this.props;

    fetch('/api/questions', {
      method: 'post',
      body: JSON.stringify({ question: { text, talk_id: talkId } }),
      headers: {
        'Content-Type': 'application/json'
      }
    })
      .then(r => r.json())
      .then(({ data }) => {
        dispatch({ type: 'UPDATE_QUESTION', payload: data });
        dispatch({ type: 'CHANGE_QUESTION_TEXT', talkId, value: '' });
      });
  }

  render() {
    const { text } = this.props;

    return (
      <div>
        <form>
          <input type="text" name="text" value={text || ''} onChange={this.changeText.bind(this)} />
          <button onClick={this.signIn.bind(this)}>Create question</button>
        </form>
      </div>
    );
  }
}
