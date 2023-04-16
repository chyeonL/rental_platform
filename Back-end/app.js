var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var bodyParser = require('body-parser')


// 创建服务器
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
// post请求
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// cookie
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));


// 路由模块化   --  前缀 /rent
var administrator = require('./routes/administrator');
app.use('/rent', administrator);

var staff = require('./routes/staff');
app.use('/rent', staff);

var landlord = require('./routes/landlord');
app.use('/rent', landlord);

var website = require('./routes/website');
app.use('/rent', website);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

//错误中间件 error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
