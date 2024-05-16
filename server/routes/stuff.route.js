const stuffController = require('../controller/stuff.controller');

const express = require('express');

const router = express.Router();


router.get('/stuff/all', stuffController.getAllMembers);
router.get('/stuff/:memberId', stuffController.getStuffOfMember);
router.post('/stuff/create', stuffController.createStuffMember);
router.put('/stuff/update', stuffController.updateStuffMember);
router.delete('/stuff/delete/:id', stuffController.deleteStuffMember);

module.exports = router;