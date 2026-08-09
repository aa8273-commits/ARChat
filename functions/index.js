const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendNotification = onDocumentCreated(
    "conversations/{conversationId}/messages/{messageId}",
    async (event) => {
        const message = event.data.data();

        const receiverId = message.receiverId;
        const senderId = message.senderId;

        const receiverDoc = await admin
            .firestore()
            .collection("users")
            .doc(receiverId)
            .get();

        const senderDoc = await admin
            .firestore()
            .collection("users")
            .doc(senderId)
            .get();

        if (!receiverDoc.exists || !senderDoc.exists) {
            return;
        }

        const receiver = receiverDoc.data();
        const sender = senderDoc.data();

        if (!receiver.token) {
            console.log("No FCM token");
            return;
        }

        const payload = {
            notification: {
                title: sender.name,
                body: message.message,
            },
            token: receiver.token,
        };

        await admin.messaging().send(payload);

        console.log("Notification sent");
    }
);