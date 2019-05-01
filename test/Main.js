exports.jslog = function(a) {
    return function () {
      console.log(a);
    }
}

exports.setTimeout = function (fn) {
   return function (delay) {
     return function () {
      setTimeout(function() {fn()} ,delay)
     }
   }
}