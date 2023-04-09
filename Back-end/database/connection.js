const mysql = require('mysql');

let conn =  mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'root',
    database:'rental_platform' 
});

module.exports = conn