import React from 'react';
import {requireNativeComponent} from 'react-native';

class ContactPickerView extends React.Component {
  render() {
    return (
      <RNContactPickerView
        {...this.props}
      />
    );
  }
}

const RNContactPickerView = requireNativeComponent('RNContactPickerView', ContactPickerView, {
  nativeOnly: {
    onCancel: true,
    onSelectContact: true,
  },
});

ContactPickerView.propTypes = {
  onCancel: React.PropTypes.func,
  onSelectContact: React.PropTypes.func.required,
};

module.exports = ContactPickerView;
