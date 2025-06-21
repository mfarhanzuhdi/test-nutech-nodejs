const pool = require('../db');
const bcrypt = require('bcryptjs');

// REGISTER
exports.register = async (req, res) => {
  const { email, first_name, last_name, password } = req.body;

  // Validasi format email
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    return res.status(400).json({
      status: 102,
      message: "Parameter email tidak sesuai format",
      data: null,
    });
  }

  // Validasi panjang password
  if (!password || password.length < 8) {
    return res.status(400).json({
      status: 103,
      message: "Password minimal 8 karakter",
      data: null,
    });
  }

  try {
    // Cek apakah email sudah terdaftar
    const existingUser = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    if (existingUser.rows.length > 0) {
      return res.status(400).json({
        status: 104,
        message: "Email sudah digunakan",
        data: null,
      });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Simpan user baru
    await pool.query(
      'INSERT INTO users (email, first_name, last_name, password) VALUES ($1, $2, $3, $4)',
      [email, first_name, last_name, hashedPassword]
    );

    res.status(200).json({
      status: 0,
      message: "Registrasi berhasil silahkan login",
      data: null,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({
      status: 500,
      message: "Internal server error",
      data: null,
    });
  }
};

const jwt = require('jsonwebtoken');

exports.login = async (req, res) => {
  const { email, password } = req.body;

  // Validasi format email
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    return res.status(400).json({
      status: 102,
      message: "Parameter email tidak sesuai format",
      data: null,
    });
  }

  // Validasi panjang password
  if (!password || password.length < 8) {
    return res.status(400).json({
      status: 103,
      message: "Password minimal 8 karakter",
      data: null,
    });
  }

  try {
    // Cek apakah user dengan email tersebut ada
    const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);

    if (result.rows.length === 0) {
      return res.status(401).json({
        status: 103,
        message: "Username atau password salah",
        data: null,
      });
    }

    const user = result.rows[0];

    // Bandingkan password dengan yang di-hash
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({
        status: 103,
        message: "Username atau password salah",
        data: null,
      });
    }

    // Generate JWT (12 jam)
    const token = jwt.sign(
      { email: user.email },
      process.env.JWT_SECRET,
      { expiresIn: '12h' }
    );

    return res.status(200).json({
      status: 0,
      message: "Login Sukses",
      data: { token },
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({
      status: 500,
      message: "Internal server error",
      data: null,
    });
  }
};

exports.profile = async (req, res) => {
  const email = req.user.email;

  try {
    const result = await pool.query('SELECT email, first_name, last_name FROM users WHERE email = $1', [email]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        status: 109,
        message: "User tidak ditemukan",
        data: null
      });
    }

    const user = result.rows[0];

    return res.status(200).json({
      status: 0,
      message: "Sukses",
      data: {
        ...user,
        profile_image: "https://yoururlapi.com/profile.jpeg"
      }
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({
      status: 500,
      message: "Internal server error",
      data: null
    });
  }
};

exports.updateProfile = async (req, res) => {
  const { first_name, last_name } = req.body;
  const email = req.user.email; // dari payload JWT

  try {
    await pool.query(
      'UPDATE users SET first_name = $1, last_name = $2 WHERE email = $3',
      [first_name, last_name, email]
    );

    // Ambil data yang baru setelah update
    const updatedUser = await pool.query(
      'SELECT email, first_name, last_name FROM users WHERE email = $1',
      [email]
    );

    const user = updatedUser.rows[0];

    res.status(200).json({
      status: 0,
      message: 'Update Pofile berhasil',
      data: {
        ...user,
        profile_image: 'https://yoururlapi.com/profile.jpeg',
      },
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