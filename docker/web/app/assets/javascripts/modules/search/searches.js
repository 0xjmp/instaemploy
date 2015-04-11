angular.module('search', ['ngResource', 'restangular'])
  .controller('SearchController', this.SearchCtlr)
  .factory('Search', this.Search)
  .directive('search', function() {
    return {
      templateUrl: 'search.html',
      controller: this.SearchCtlr
    };
  });