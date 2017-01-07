import React, { Component } from 'react';
import { connect } from 'react-redux'
import {bindActionCreators} from 'redux';

import { loadFrame } from './actions'
import { loadStreams } from '../streams/actions'

class Frame extends Component {

  componentWillMount() {
    this.props.loadFrame(this.props.params.frameId)
    this.props.loadStreams()
  }

  render() {
    return (
      <div>
        <h1>{this.props.frame.name}</h1>
      </div>)
  }

}

function mapDispatchToProps(dispatch) {
    return bindActionCreators({loadFrame, loadStreams}, dispatch);
}

function mapStateToProps(state) {
    return {
        frame: state.frame.item,
        isLoaded: state.frame.isLoaded,
        streams: state.streams.items
    };
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Frame)
