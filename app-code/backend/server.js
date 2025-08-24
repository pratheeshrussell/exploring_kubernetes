const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());

// Database configuration
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
  ssl: (process.env.DB_TLS && process.env.DB_TLS.toLowerCase() == 'true') ? {
    rejectUnauthorized: false,
  } : false,
});

// Get random quote
app.get('/api/quotes/random', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT text, author 
      FROM quotes.messages 
      ORDER BY RANDOM() 
      LIMIT 1
    `);

    const quote = result.rows[0];

    console.log(`Quote fetched: ${JSON.stringify(quote)}`);
    res.json(quote);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.listen(port, () => {
  console.log(`Backend running on port ${port}`);
});