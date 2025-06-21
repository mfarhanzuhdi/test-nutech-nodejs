const express = require('express');
const router = express.Router();
const { uploadProfileImage } = require('../controllers/profileController');
const authController = require('../controllers/authController');
const bannerController = require('../controllers/bannerController');
const serviceController = require('../controllers/serviceController');
const balanceController = require('../controllers/balanceController');
const transactionController = require('../controllers/transactionController');
const { topUpBalance } = require('../controllers/balanceController');
const verifyToken = require('../middlewares/authMiddleware');
const upload = require('../middlewares/uploadMiddleware');

router.post('/registration', authController.register);
router.post('/login', authController.login);
router.get('/profile', verifyToken, authController.profile);
router.put('/update', verifyToken, authController.updateProfile);
router.put('/profile/image', verifyToken, upload.single('file'), uploadProfileImage);
router.get('/banner', bannerController.getBanners);
router.get('/services', verifyToken, serviceController.getServices);
router.get('/balance', verifyToken, balanceController.getBalance);
router.post('/topup', verifyToken, topUpBalance);
router.post('/transaction', verifyToken, transactionController.transaction);
router.get('/transaction/history', verifyToken, transactionController.getTransactionHistory);

module.exports = router;
