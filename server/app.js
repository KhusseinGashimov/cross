const express = require('express');
const cookieParser = require('cookie-parser');
const cors = require("cors");
const accountRouter = require('./routes/account.route');
const stuffRouter = require('./routes/stuff.route');
const swaggerUi = require('swagger-ui-express');
const swaggerJsdoc = require('swagger-jsdoc');
const app = express();

const swaggerOptions = {
    definition: {
        openapi: '3.0.0',
        info: {
            title: 'Flutter Movie API',
            version: '1.0.0',
            description: 'A simple Express Library API',
        },
        servers: [
            {
                url: 'http://localhost:3000',
            },
        ],
    },
    apis: ['./routes/*.js'], // Path to the API docs
};

const swaggerDocs = swaggerJsdoc(swaggerOptions);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocs));


app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cors())
app.use(cookieParser());
app.use(accountRouter);
app.use(stuffRouter);
app.listen(
    3000,
    () => console.log('Server is running on http://localhost:3000')
)