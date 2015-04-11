var modules = [
'ngMaterial',
'ngResource',
'ngRoute',
'templates',
'navigation',
'projects',
'explore',
'users',
'alert',
'restangular',
'ngAnimate',
'search'
];

angular.module('instaemploy', modules)
  .filter('capitalize', this.Capitalize)
  .filter('datetime', this.Datetime)
  .config(this.Config)
  .run(this.Run);