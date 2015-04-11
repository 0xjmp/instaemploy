angular.module('explore', ['projects', 'search', 'ngRoute', 'alert'])
  .factory('Explore', this.Explore)
  .controller('ExploreController', this.ExploreCtlr);