client/public/index.html
client/public/logo192.png
client/public/logo512.png
client/public/manifest.json
client/public/robots.txt
client/src/App.css
client/src/App.js
client/src/App.test.js
client/src/components/createStudent/createStudent.js
client/src/components/showStudent/showStudent.js
client/src/index.css
client/src/index.js
client/src/logo.svg
client/src/reportWebVitals.js
client/src/setupTests.js
client/src/styles.js
client/yarn.lock
controllers/studentController.js
database/studentDB.js
index.js
models/studentModel.js
package.json
routes/studentRoutes.jsconst express = require("express");
const {
  getStudents,
  createStudent,
  deleteStudent,
} = require("../controllers/studentController");

const router = express.Router();

router.get("/", getStudents);
router.post("/", createStudent);
router.delete("/:id", deleteStudent);

module.exports = router;
