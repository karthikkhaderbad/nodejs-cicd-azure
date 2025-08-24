const express = require('express');
const app = express();

app.get('/', (req, res) => res.send({ message: "Hello World" }));
app.get('/health', (req, res) => res.send({ status: "ok" }));

app.listen(3000, () => console.log("Server running on port 3000"));
