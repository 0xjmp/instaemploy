this.Alert = function($mdToast) {
  var scope = {};

  scope.add = function(type, msg) {
    $mdToast.showSimple(msg);
  };

  scope.$get = function() {
    return scope;
  };

  return scope;
};