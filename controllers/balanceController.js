const pool = require('../db');

exports.getBalance = async (req, res) => {
  try {
    const email = req.user.email; // diambil dari JWT payload

    const result = await pool.query(
      'SELECT balance FROM users WHERE email = $1',
      [email]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        status: 104,
        message: "User tidak ditemukan",
        data: null
      });
    }

    res.status(200).json({
      status: 0,
      message: "Get Balance Berhasil",
      data: {
        balance: result.rows[0].balance
      }
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({
      status: 500,
      message: "Internal server error",
      data: null
    });
  }
};

exports.topUpBalance = async (req, res) => {
  const email = req.user.email;
  const { top_up_amount } = req.body;

  // Validasi angka
  if (!Number.isInteger(top_up_amount) || top_up_amount < 0) {
    return res.status(400).json({
      status: 102,
      message: "Parameter amount hanya boleh angka dan tidak boleh lebih kecil dari 0",
      data: null
    });
  }

  try {
    // Tambahkan saldo
    const updateQuery = `
      UPDATE users 
      SET balance = balance + $1 
      WHERE email = $2
      RETURNING balance
    `;
    const updateResult = await pool.query(updateQuery, [top_up_amount, email]);

    // Catat ke tabel transaksi (opsional)
    const insertTxn = `
      INSERT INTO transactions (email, transaction_type, amount, created_at)
      VALUES ($1, 'TOPUP', $2, NOW())
    `;
    await pool.query(insertTxn, [email, top_up_amount]);

    res.status(200).json({
      status: 0,
      message: "Top Up Balance berhasil",
      data: {
        balance: updateResult.rows[0].balance
      }
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ status: 500, message: "Internal server error", data: null });
  }
};