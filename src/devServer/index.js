const express = require('express');

const {
  PORT = 3000,
} = process.env;

const port = PORT;
const app = express();
const phile = require('./phile')

app.use(phile);

const server = app.listen(port);

/*
 * When being used in nodemon, SIGUSR2 is issued to restart the process. We
 * listen for this and shut down cleanly.
 */
process.once('SIGUSR2', function() {
  server.close();
  const t = setTimeout(function() {
    process.kill(process.pid, 'SIGUSR2');
  }, 200);
  // Don't prevent clean shutdown:
  t.unref();
});

console.log(`listening on http://localhost:${port}/graphiql`);