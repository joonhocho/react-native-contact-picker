/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, {Component} from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
} from 'react-native';
import AddContact from 'react-native-add-contact';
import imageData from './imageBase64';

export default class ExampleApp extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.android.js
        </Text>
        <Text style={styles.instructions}>
          Double tap R on your keyboard to reload,{'\n'}
          Shake or press menu button for dev menu
        </Text>
        <TouchableHighlight onPress={async () => {
          const res = await AddContact.addContact({
            type: 'organization',

            name: {
              prefix: 'Mr.',
              givenName: 'John',
              middleName: 'Philip',
              familyName: 'Doe',
              previousFamilyName: 'Dope',
              suffix: 'Jr.',

              phoneticGivenName: 'Jon',
              phoneticMiddleName: 'Fil',
              phoneticFamilyName: 'Do',
            },

            nicknames: [{
              label: 'initials',
              name: 'JPD',
            }, {
              name: 'Jony',
            }],

            organizations: [{
              company: 'Google',
              department: 'Engineering',
              title: 'Software Engineer',

              phoneticCompany: 'Gugle',
            }],

            notes: [{
              note: 'This is notes, and it\'s about John.\nHello.',
            }, {
              note: 'This is,\n another note.',
            }],

            photos: [{
              data: imageData,
              // uri: 'http://cdn.newsapi.com.au/image/v1/335a6997d394c4d65a00aadc99c4fd44',
            }],

            phones: [{
              label: 'home',
              number: '123 456 7890',
            }, {
              label: 'work',
              number: '+1 234 567 8901',
            }, {
              label: 'my phone',
              number: '+1239479223',
            }],

            emails: [{
              label: 'Home',
              address: 'john@gmail.com',
              displayName: 'John Doe',
            }, {
              label: 'Happy',
              address: 'happy@gmail.com',
            }, {
              label: 'Other',
              address: 'johnie@hotmail.com',
            }],

            postals: [{
              label: 'home',
              street: '123 Forbes Ave, Apt 1',
              subLocality: null,
              city: 'San Francisco',
              subAdministrativeArea: null,
              state: 'CA',
              postalCode: '12345-5678',
              country: 'USA',
              isoCountryCode: 'US',
            }, {
              label: 'Vacation Home',
              street: '234 Forbes Ave',
              subLocality: 'subloc',
              city: 'Ocean City',
              subAdministrativeArea: 'subadmin',
              state: 'Hawaii',
              postalCode: '12345-5678',
              country: 'USA',
              isoCountryCode: 'US',
            }],

            websites: [{
              label: 'google',
              url: 'http://google.com',
            }, {
              label: 'test',
              url: 'test.com',
            }, {
              label: 'company',
              url: 'http://mycompany.com',
            }],

            relations: [{
              label: 'father',
              name: 'Father Doe',
            }, {
              label: 'stranger',
              name: 'Stranger Joe',
            }, {
              label: 'mother',
              name: 'Mother Toe',
            }],

            socialProfiles: [{
              label: null,
              url: null,
              username: 'mark',
              userId: null,
              service: 'facebook',
            }, {
              label: null,
              url: null,
              username: 'google',
              userId: null,
              service: 'twitter',
            }],

            ims: [{
              label: 'my aim',
              service: 'aim',
              username: 'aimer',
            }, {
              label: 'my msn',
              service: 'msn',
              username: 'msner',
            }, {
              label: 'my yahoo',
              service: 'yahoo',
              username: 'yahooer',
            }, {
              label: 'home',
              service: 'facebook',
              username: 'facebooker',
            }],

            birthday: {
              year: 1999,
              month: 1,
              day: 31,
            },

            nonGregorianBirthday: null && {
              year: 2000,
              month: 2,
              day: 28,
            },

            dates: [{
              label: 'anniversary',
              year: 2001,
              month: 3,
              day: 30,
            }, {
              label: 'fun day',
              year: 2002,
              month: 4,
              day: 1,
            }],

            sipAddresses: [{
              label: 'SIPADR',
              sipAddress: 'skype/sip',
            }],
          });

          alert(JSON.stringify(res, null, '  '));
        }}>
          <Text style={styles.instructions}>
            Test
          </Text>
        </TouchableHighlight>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('ExampleApp', () => ExampleApp);
