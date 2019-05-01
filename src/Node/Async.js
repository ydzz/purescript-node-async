var async = require("async");
var fs = require("fs");

exports.ttt = function() {
  fs.readdir("/home/yangdao/Project", function(err, files) {
    if (err) {
      console.log(err);
    }
    console.log(files);
  });
};

function exportAsyncFunc(funcName,resultFuncArgLength) {
  return function(arr) {
    return function(func) {
      return function(resultFunc) {
        return function() {
          return async[funcName](
            arr,
            function(a, callback) {
              func(a)(callback)();
            },
            function(err, result) {
              switch(resultFuncArgLength){
                 case 1:
                   resultFunc(err)();
                 break;
                 case 2:
                   resultFunc(err)(result)();
                 break;
              }
              
            }
          );
        };
      };
    };
  };
}

exports.everyImpl = exportAsyncFunc("every",2);

exports.concatImpl = exportAsyncFunc("concat",2);

exports.eachImpl = exportAsyncFunc("each",1);

exports.eachSeriesImpl = exportAsyncFunc("eachSeries",1);
