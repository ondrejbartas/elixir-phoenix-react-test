import React, { Component, PropTypes as RPT } from 'react';

export default class Question extends Component {

  static propTypes = {
    text: RPT.string,
    likes: RPT.number
  }

  render() {
    const { text, likes } = this.props;

    return (
      <div>
        {text}
        <div style={{ color: 'green' }}>{likes}</div>
      </div>
    );
  }
}
