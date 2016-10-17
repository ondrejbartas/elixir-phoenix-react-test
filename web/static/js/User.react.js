import React, { Component, PropTypes as RPT } from 'react';
import fetch from 'isomorphic-fetch';

export default class User extends Component {
  static contextTypes = {
    store: RPT.object.isRequired
  }

  static propTypes = {
    name: RPT.string
  }

  changeName({ target: { value } }) {
    const { store: { dispatch } } = this.context;

    dispatch({
      type: 'CHANGE_USER_NAME',
      value
    });
  }

  signIn(e) {
    e.preventDefault();
    const { store: { dispatch } } = this.context;
    const { name } = this.props;

    fetch('/api/users', {
      method: 'post',
      body: JSON.stringify({ user: { name } }),
      headers: {
        'Content-Type': 'application/json'
      }
    })
      .then(r => r.json())
      .then(({ data }) => dispatch({ type: 'USER_CREATED', data }));
  }

  render() {
    const { name } = this.props;

    return (
      <div>
        <form>
          <input type="text" name="username" value={name} onChange={this.changeName.bind(this)} />
          <button onClick={this.signIn.bind(this)}>Sign in</button>
        </form>
      </div>
    );
  }
}
