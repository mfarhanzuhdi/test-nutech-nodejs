const express = require('express');
const app = express();
require('dotenv').config();

const authRoutes = require('./routes/authRoutes');

app.use(express.json());

// Routes
app.use('/api', authRoutes);

// Root check
app.get('/', (req, res) => {
  res.send('Nutech API is running...');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
