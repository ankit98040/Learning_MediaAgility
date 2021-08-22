const express = require('express');
const app = express();
const Joi = require('joi');
const logger = require('./logger');

app.use(express.json()); //middleware
app.use(express.urlencoded());

//1st middleware
// app.use(function(req, res, next){
// 	console.log('logging...');
// 	next(); //passes control to next middleware function
// });

app.use(logger);

app.use(function(req, res, next){
	console.log('Authentication...');
	next();
});

// app.get()
// app.post()
// app.put()
// app.delete()

const courses = [
	{id: 1, name: 'IT'},
		{id: 2, name: 'ECE'},
			{id: 3, name: 'CSE'},
				{id: 4, name: 'ME'}
];

app.get('/', (req, res) => {
	res.send('Hello world')
});
app.get('/api/courses', (req, res) => {
	res.send(courses)
});
// app.get('/api/courses/:id', (req, res) => {
// 	let course = courses.find(c => {c.id === parseInt(req.params.id));

	
// 	if (!course) res.status(404).send('This course not found');
// 	res.send(course)
// });

app.get('/api/courses/:id', (req,res) => {
	const course = courses.find(c => c.id === parseInt(req.params.id));
	if (!course)  return res.status(404).send('Course not found')
	res.send(course)
})

//POST request
app.post('/api/courses', (req, res) => {
	const { error } = validateCourse(req.body); //error body

	if (error) return res.status(400).send(error.details[0].message)

	const course = {
		id: courses.length + 1,
		name: req.body.name
	};
	courses.push(course);
	res.send(course);
});

//PUT request
app.put('/api/courses/:id', (req, res) => {
	//if course not present, return 404
	const course = courses.find(c => c.id === parseInt(req.params.id));
	if (!course) return res.status(404).send("Course not found");

	

	//validate - if invalid return bad request 400
	// const schema = {
	// 	name: Joi.string().min(3).required()
	// 	};
	// const result = Joi.validate(req.body, schema);
	//const result = validateCourse(req.body);
	const { error } = validateCourse(req.body); //error body

	if (error) return res.status(400).send(error.details[0].message)

	

	//update course - return updated course
	course.name = req.body.name;
	res.send(course);
});


function validateCourse(course) {
	const schema = {
		name: Joi.string().min(3).required()
		};
	return Joi.validate(course, schema);
}


//delete request

app.delete('/api/courses/:id', (req, res) => {
	const course = courses.find(c => c.id === parseInt(req.params.id));
	if (!course)  return res.status(404).send("Course not found")

	const index = courses.indexOf(course);
	courses.splice(index, 1);

	res.send(course);

})
	
			








//env variables
const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`listening on port ${port}....`))
