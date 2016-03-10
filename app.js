'use strict';

const APP_PORT = 3000;
const SOUNDS_FOLDER = 'sounds';

let express = require('express');
let app = express();

app.use(express.static('public'));

app.get('/sounds', function(req, res) {
  res.send(soundFiles());
});

app.get('/add', function(req, res) {
  res.sendStatus(201);
  console.log("add " + req.query.text);
  add(req.query.text);
});

app.get('/play', function(req, res) {
  res.sendStatus(200);
  console.log("play " + req.query.id);
  play(req.query.id);
});

app.listen(APP_PORT, function() {
  console.log("supercool soundbox started...");
  console.log("visit on http://localhost:" + APP_PORT);
});

function play(id) {
  let execFile = require('child_process').execFile;
  execFile('notepad.exe', [], function callback(error, stdout, stderr) {

  });
}

function add(text) {
  
}

function hash(text) {
  return require('crypto').createHash('md5').update(text).digest('hex');
}

function soundFiles() {
  let readdirSync = require('fs').readdirSync;
  return readdirSync(SOUNDS_FOLDER).map((f) => ({id: hash(f), text: f}));
}
