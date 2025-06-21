const pool = require('../db');

exports.getBanners = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM banners');
    
    const banners = result.rows.map(row => ({
      banner_name: row.banner_name,
      banner_image: row.banner_image
    }));

    res.status(200).json({
      status: 0,
      message: "Sukses",
      data: banners
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      status: 500,
      message: "Internal server error",
      data: null
    });
  }
};
