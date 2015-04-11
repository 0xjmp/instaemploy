angular.module('projects', ['ngRoute', 'restangular', 'ngMaterial'])
  .controller('ProjectsController', this.ProjectsCtlr)
  .factory('Project', this.Project)
  .directive('projectTable', function() {
    return {
      templateUrl: 'project-table.html',
      scope: {
        projects: '=',
        nouser: '=',
        tabs: '='
      },
      controller: this.ProjectsCtlr
    };
  })
  .directive('accepted', function() {
    return {
      templateUrl: 'accepted.html',
      restrict: 'A',
      scope: {
        accepted: '=',
        disabled: '&'
      }
    };
  });