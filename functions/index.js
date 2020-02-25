const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

exports.saveUserOnDatabase = functions.auth.user().onCreate((user) => {
    return db.collection('users').add({uid: user.uid, email: user.email, displayName: user.displayName});
});