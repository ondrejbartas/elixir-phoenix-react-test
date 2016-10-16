import React, { Component } from 'react';

export default ({ text, likes }) => (
  <div>
    {text}
    <div style={{color: 'green'}}>{likes}</div>
  </div>
)
