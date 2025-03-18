const express = require('express');
const path = require('path');
const AWS = require('aws-sdk');
const app = express();
const port = 3000;

// Load environment variables (assuming you have an .env file)
const appName = process.env.APP_NAME;
const s3BucketName = 'aws-tf-back'

// Initialize AWS S3 client
const s3 = new AWS.S3();

app.use('/images', express.static(path.join(__dirname, 'images')));
app.use('/css', express.static(path.join(__dirname, 'css')));
app.use('/js', express.static(path.join(__dirname, 'js')));

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));

// Route for home page
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Route for about page
app.get('/about', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'about.html'));
});

// Route for class page
app.get('/class', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'class.html'));
});

// Route for blog page
app.get('/blog', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'blog.html'));
});

// Dynamically fetch an image from S3 if not found locally
app.get('/images/:imageName', async (req, res) => {
    const imageName = req.params.imageName;

    try {
        // First, check if the file exists locally
        const filePath = path.join(__dirname, 'images', imageName);
        if (require('fs').existsSync(filePath)) {
            return res.sendFile(filePath);
        }

        // If not, fetch the image from S3
        const s3Params = {
            Bucket: s3BucketName,
            Key: `images/${imageName}`, // Adjust this based on how files are stored in S3
        };

        const data = await s3.getObject(s3Params).promise();
        res.setHeader('Content-Type', data.ContentType);
        res.send(data.Body);
    } catch (error) {
        console.error('Error fetching image from S3:', error);
        res.status(500).send('Error fetching image');
    }
});

app.listen(port, () => {
    console.log(`${appName} is listening on port ${port}`);
});

























// const express = require('express');
// const path = require('path');
// const app = express();
// const port = 3000;

// const appName = process.env.APP_NAME

// app.use('/images', express.static(path.join(__dirname, 'images')));
// app.use('/css', express.static(path.join(__dirname, 'css')));
// app.use('/js', express.static(path.join(__dirname, 'js')));



// // Serve static files
// app.use(express.static(path.join(__dirname, "public")));

// // Route for home page
// app.get("/", (req, res) => {
//     res.sendFile(path.join(__dirname, "public", "index.html"));
// });

// // Route for about page
// app.get("/about", (req, res) => {
//     res.sendFile(path.join(__dirname, "public", "about.html"));
// });

// app.get("/class", (req, res) => {
//     res.sendFile(path.join(__dirname, "public", "class.html"));
// });

// app.get("/blog", (req, res) => {
//     res.sendFile(path.join(__dirname, "public", "blog.html"));
// });

// app.listen(port, () => {
//     console.log(`${appName} is listening on port ${port}`);
// });
