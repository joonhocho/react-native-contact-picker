const {
  NativeModules: {
    RNContactPicker,
  },
} = require('react-native');


module.exports = {
  name: RNContactPicker.name,

  pickContact(opts) {
    return RNContactPicker.pickContact(opts || {});
  },

  pickContacts(opts) {
    return RNContactPicker.pickContacts(opts || {});
  },
};
