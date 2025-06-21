const pool = require('../db');

exports.getServices = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM services');

    res.status(200).json({
      status: 0,
      message: "Sukses",
      data: result.rows
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
