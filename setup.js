var mysql = require('mysql');
const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

var loginInfo = new Object(); //objects in JavaScript are more like dictionaries

var questions = [ //list of questions to ask
    "host (default localhost): ",
    "user (default root): ",
    "password: "
];
var answers = [];

getInput = (callback) => {
    rl.question(questions[0], function (ans) {
        answers.push(ans);
        rl.setPrompt(questions[1]);
        rl.prompt();
        rl.on('line', function (ans) {
            if (answers.length < questions.length - 1) {
                answers.push(ans.trim());
                rl.setPrompt(questions[answers.length]);
                rl.prompt();
            } else if (answers.length = questions.length - 1) {
                answers.push(ans.trim());
                rl.close();
                callback();
            }
        });
    });
}

function initialize(callback = null) {

    getInput(() => {
        if (callback != null) {
            callback();
        }
    });
}

function connect() {
    loginInfo.host = answers[0];
    loginInfo.user = answers[1];
    loginInfo.password = answers[2];
    loginInfo.database = answers[3];
    connection = mysql.createConnection(loginInfo);
    connection.connect();

    connection.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
        if (error) throw error;
        if (results[0].solution === 2) {
            console.log('Test query successful');
        }
        console.log("Connection state: " + connection.state);
        setup();
    });
}
var connection;
initialize(connect);



//run after initialize has completed
function setup() {
    const fs = require('fs');
    var queryString;
    var fileString = 'DB Setup/setup.sql';
    var configFile = fs.readFileSync("config.json");
    var config = JSON.parse(configFile);
    if(config.newSQL == "true") {
        fileString = 'DB Setup/setup2.sql';
    }
    fs.readFile(fileString, (err, data) => {
        if (err) throw err;
        queryString = data.toString();
        connection.query(queryString, function (error) {
            if (error) throw error;
            console.log("Database established");
        });
    });
}