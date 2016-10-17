import React, { Component, PropTypes as RPT } from 'react';
import Talk from './Talk.react';
import { connect } from 'react-redux';

class App extends Component {
  static propTypes = {
    talks: RPT.object
  }

  render() {
    const { talks } = this.props;

    return (
      <div>
        <h1>Questhor 22</h1>
        {talks.map((talk) => <Talk key={talk.get('name')} name={talk.get('name')} questions={talk.get('questions')} />)}
      </div>
    );
  }
}


export default connect(
  state => ({ talks: state.get('talks') })
)(App);
