var express = require('express');
var router = express.Router();
var os = require('os');

/* GET home page. */
router.get('/', function(req, res, next) {
	res.render('index', {
		num_cpu_cores: os.cpus().length,
		total_memory: os.totalmem(),
		hostname: os.hostname()
	});
});

module.exports = router;