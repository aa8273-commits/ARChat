const express = require("express");
const cors = require("cors");
require("dotenv").config();

const { initializeApp, cert } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");

const app = express();

app.use(cors());
app.use(express.json());

const serviceAccount = require("./serviceAccountKey.json");

initializeApp({
    credential: cert(serviceAccount),
});

const db = getFirestore();
db.settings({ preferRest: true });

const messaging = getMessaging();

console.log("Firebase initialized successfully");

// Test Route
app.get("/", (req, res) => {
    res.send("AR Chat Notification Server Running");
});


async function sendNotification(token, senderName, messageText) {
    const payload = {
        token,

        notification: {
            title: senderName,
            body: messageText,
        },

        data: {
            type: "chat",
        },
    };

    try {
        await messaging.send(payload);
        console.log("Notification sent");
    } catch (error) {
        console.log("Notification Error:", error);
    }
}


let firstLoad = true;

// Keep track of messages already processed
const processedMessages = new Set();

db.collectionGroup("messages").onSnapshot(
    (snapshot) => {
        if (firstLoad) {
            firstLoad = false;
            console.log("Old messages skipped");
            return;
        }

        snapshot.docChanges().forEach(async (change) => {
            if (change.type !== "added") return;

            // Unique ID of the Firestore message
            const messageId = change.doc.id;

            // Prevent duplicate notifications
            if (processedMessages.has(messageId)) {
                console.log("Duplicate message skipped:", messageId);
                return;
            }

            processedMessages.add(messageId);

            const data = change.doc.data();

            console.log("Message ID:", messageId);
            console.log("Message Path:", change.doc.ref.path);
            console.log("Message:", data.message);

            const receiverId = data.receiverId;
            const senderId = data.senderId;

            if (!receiverId) {
                console.log("No receiverId on message");
                return;
            }

            if (!senderId) {
                console.log("No senderId on message");
                return;
            }

            try {
                const receiverDoc = await db
                    .collection("users")
                    .doc(receiverId)
                    .get();

                if (!receiverDoc.exists) {
                    console.log("Receiver not found");
                    return;
                }

                const receiverData = receiverDoc.data();
                const token = receiverData.token;

                if (!token) {
                    console.log("No FCM token");
                    return;
                }

                const senderDoc = await db
                    .collection("users")
                    .doc(senderId)
                    .get();

                if (!senderDoc.exists) {
                    console.log("Sender not found");
                    return;
                }

                const senderData = senderDoc.data();
                const senderName = senderData.name || "User";

                console.log("Sender:", senderName);
                console.log("Receiver:", receiverId);

                await sendNotification(
                    token,
                    senderName,
                    data.message
                );

            } catch (e) {
                console.log("Error:", e);
            }
        });
    },

    (error) => {
        console.log("Firestore listener error:", error);
    }
);