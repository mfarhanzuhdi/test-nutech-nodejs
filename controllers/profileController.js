exports.uploadProfileImage = async (req, res) => {
  const email = req.user.email;
  const file = req.file;
  const pool = require('../db');

  if (!file) {
    return res.status(400).json({
      status: 102,
      message: 'Format Image tidak sesuai',
      data: null,
    });
  }

  try {
    const imageUrl = `https://yoururlapi.com/${file.filename}`; // atau sesuaikan dengan host kamu

    // Simpan ke database
    await pool.query('UPDATE users SET profile_image = $1 WHERE email = $2', [imageUrl, email]);

    // Ambil data user setelah update
    const result = await pool.query('SELECT email, first_name, last_name, profile_image FROM users WHERE email = $1', [email]);
    const user = result.rows[0];

    res.status(200).json({
      status: 0,
      message: 'Update Profile Image berhasil',
      data: user,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({
      status: 500,
      message: 'Internal server error',
      data: null,
    });
  }
};
