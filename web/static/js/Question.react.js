import React, { Component } from 'react';

export default class Question extends Component {

  render() {
    const { text, likes } = this.props;

    return (
      <div>
        {text}
        <div style={{color: 'green'}}>{likes}</div>
      </div>
    )
  }
}
