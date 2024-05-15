const express = require('express');
const bodyParser = require('body-parser');
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json'); // Убедитесь, что файл находится в папке backend

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://console.firebase.google.com/u/0/project/cross-d8dce/firestore/databases/-default-/data/~2F'
});

const db = admin.firestore();
const app = express();
app.use(bodyParser.json());

// Пример маршрута для добавления данных
app.post('/addData', async (req, res) => {
  try {
    const docRef = db.collection('your-collection').doc();
    await docRef.set(req.body);
    res.status(200).send('Document successfully written!');
  } catch (error) {
    console.error('Error writing document: ', error);
    res.status(500).send('Error writing document');
  }
});

// Другие маршруты для работы с данными
app.post('/auth/login', async (req, res) => {
  // Логика авторизации
});

app.get('/bookings', async (req, res) => {
  // Логика получения бронирований
});

app.get('/actors', async (req, res) => {
  // Логика получения списка актеров
});

app.get('/comments', async (req, res) => {
  // Логика получения комментариев
});

app.get('/news', async (req, res) => {
  // Логика получения новостей
});

app.get('/stuff', async (req, res) => {
  // Логика получения списка вещей
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
