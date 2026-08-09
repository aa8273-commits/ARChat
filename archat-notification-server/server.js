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
const messaging = getMessaging();

console.log("Firebase initialized successfully");

// Test Route
app.get("/", (req, res) => {
    res.send("AR Chat Notification Server Running");
});

// Send Notification
async function sendNotification(token, messageText) {
    const payload = {
        token,
        notification: {
            title: "New Message",
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

// Listen for new messages
let firstLoad = true;

db.collectionGroup("messages").onSnapshot(
    (snapshot) => {
        if (firstLoad) {
            firstLoad = false;
            console.log("Old messages skipped");
            return;
        }

        snapshot.docChanges().forEach(async (change) => {
            if (change.type !== "added") return;

            const data = change.doc.data();

            console.log("New message:", data.message);

            const receiverId = data.receiverId;

            if (!receiverId) {
                console.log("No receiverId on message");
                return;
            }

            try {
                const userDoc = await db.collection("users").doc(receiverId).get();

                if (!userDoc.exists) {
                    console.log("Receiver not found");
                    return;
                }

                const token = userDoc.data().token;

                if (!token) {
                    console.log("No FCM token");
                    return;
                }

                await sendNotification(token, data.message);
            } catch (e) {
                console.log("Error:", e);
            }
        });
    },
    (error) => {
        console.log("Firestore listener error:", error);
    }
);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});