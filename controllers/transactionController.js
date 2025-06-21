const pool = require('../db');

exports.transaction = async (req, res) => {
  const email = req.user.email;
  const { service_code } = req.body;

  if (!service_code) {
    return res.status(400).json({
      status: 102,
      message: "Service ataus Layanan tidak ditemukan",
      data: null,
    });
  }

  try {
    const userResult = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    const user = userResult.rows[0];
    if (!user) throw new Error('User not found');

    const serviceResult = await pool.query('SELECT * FROM services WHERE service_code = $1', [service_code]);
    const service = serviceResult.rows[0];

    if (!service) {
      return res.status(400).json({
        status: 102,
        message: "Service ataus Layanan tidak ditemukan",
        data: null,
      });
    }

    if (user.balance < service.service_tariff) {
      return res.status(400).json({
        status: 102,
        message: "Saldo tidak mencukupi",
        data: null,
      });
    }

    // Generate invoice
    const invoiceNumber = `INV${Date.now()}`;
    const createdOn = new Date();

    // Update balance
    const newBalance = user.balance - service.service_tariff;
    await pool.query('UPDATE users SET balance = $1 WHERE email = $2', [newBalance, email]);

    // Insert transaction
    await pool.query(
      'INSERT INTO transactions (invoice_number, email, service_code, transaction_type, total_amount, created_on) VALUES ($1, $2, $3, $4, $5, $6)',
      [invoiceNumber, email, service_code, 'PAYMENT', service.service_tariff, createdOn]
    );

    return res.json({
      status: 0,
      message: "Transaksi berhasil",
      data: {
        invoice_number: invoiceNumber,
        service_code: service.service_code,
        service_name: service.service_name,
        transaction_type: "PAYMENT",
        total_amount: service.service_tariff,
        created_on: createdOn.toISOString()
      }
    });

  } catch (err) {
    console.error(err);
    return res.status(500).json({
      status: 500,
      message: "Internal Server Error",
      data: null,
    });
  }
};

exports.getTransactionHistory = async (req, res) => {
  const email = req.user.email;
  const offset = parseInt(req.query.offset) || 0;
  const limit = req.query.limit ? parseInt(req.query.limit) : null;

  try {
    let query = `
      SELECT t.invoice_number, t.transaction_type, 
             CASE 
               WHEN t.transaction_type = 'TOPUP' THEN 'Top Up balance'
               ELSE s.service_name
             END AS description,
             t.total_amount, t.created_on
      FROM transactions t
      LEFT JOIN services s ON t.service_code = s.service_code
      WHERE t.email = $1
      ORDER BY t.created_on DESC
    `;

    const params = [email];
    if (limit !== null) {
      query += ` LIMIT $2 OFFSET $3`;
      params.push(limit, offset);
    }

    const result = await pool.query(query, params);

    return res.status(200).json({
      status: 0,
      message: "Get History Berhasil",
      data: {
        offset,
        limit: limit || result.rowCount,
        records: result.rows
      }
    });

  } catch (err) {
    console.error(err);
    return res.status(500).json({
      status: 500,
      message: "Internal Server Error",
      data: null
    });
  }
};
