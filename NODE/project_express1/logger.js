function log(req, res, next){
	console.log('logging...');
	next(); //passes control to next middleware function
}

module.exports = log;