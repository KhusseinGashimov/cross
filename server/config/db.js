const admin = require('firebase-admin');
const serviceAccount = require('./cross-d8dce-firebase-adminsdk-ejw93-97e19748ce.json');
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});
const db = admin.firestore();
const auth = admin.auth();
const bucket = admin.storage().bucket('gs://cross-d8dce.appspot.com');

module.exports = { db, auth,bucket};