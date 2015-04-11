angular.module('users', ['ngCookies', 'ngRoute', 'ngResource', 'restangular', 'projects', 'skills'])
  .controller('UsersController', this.UsersCtlr)
  .factory('User', this.User)
  .directive('xpBar', function() {
    return {
      templateUrl: 'xp-bar.html',
      restrict: 'E',
      scope: {
        xp: '='
      }
    };
  })
  .directive('omniauthBtns', function() {
    return {
      scope: true,
      templateUrl: 'omniauth-btns.html'
    };
  });