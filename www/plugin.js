var cordova = require("cordova");

var PLUGIN_NAME = "PaciolanSDK";

function PaciolanSDK() {
  this.show = function(initializationParams, success, error) {
    return new Promise(function(resolve, reject) {
      var params = [initializationParams];

      cordova.exec(
        success || resolve,
        error || reject,
        "PaciolanSDK",
        "show",
        params
      );
    });
  };
  this.getToken = function(success, error) {
    return new Promise(function(resolve, reject) {
      cordova.exec(
        success || resolve,
        error || reject,
        "PaciolanSDK",
        "getPaciolanJWT",
        null
      );
    });
  };
}

module.exports = new PaciolanSDK();
