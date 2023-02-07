
var cron = require('node-cron');
const { syncDb } = require('./tasks/sync-db');

console.log('app con pruebas');


cron.schedule('1-59/5 * * * * * *', syncDb );