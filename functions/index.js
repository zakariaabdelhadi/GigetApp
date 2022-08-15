// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
// The Firebase Admin SDK to access Firestore.
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
exports.createUser = functions.firestore
    .document("Userss/{userId}")
    .onCreate((snap, context) => {
      console.log("good job");
    });
