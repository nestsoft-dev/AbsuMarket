const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.scheduledFunction = functions.pubsub
  .schedule("every 1 minutes")
  .onRun((context) => {
    const now = admin.firestore.Timestamp.now();
    const postsRef = admin.firestore().collection("posts");

    return postsRef
      .where("expirationTime", "<=", now)
      .get()
      .then((snapshot) => {
        const batch = admin.firestore().batch();

        snapshot.forEach((doc) => {
          batch.delete(doc.ref);
        });

        return batch.commit();
      });
  });
