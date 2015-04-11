angular.module('navigation', ['users', 'ngRoute', 'ngMaterial', 'projects'])
  .controller('NavigationController', this.NavigationCtlr)
  .directive('navHeader', function() {
    return {
      templateUrl: 'navigation.html',
      controller: this.NavigationCtlr
    };
  });