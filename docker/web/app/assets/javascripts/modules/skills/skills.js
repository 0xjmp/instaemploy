angular.module('skills', ['restangular', 'ngRoute', 'ngMaterial'])
  .controller('SkillsController', this.SkillsCtlr)
  .factory('Skill', this.Skill)
  .directive('skillGrid', function() {
    return {
      controller: this.SkillsCtlr,
      templateUrl: 'skills.html',
      scope: {
        skills: '='
      }
    };
  });