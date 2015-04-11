this.SkillsCtlr = function($scope, Skill, $location, $mdDialog) {

  $scope.fetchSkill = function(name) {
    Skill.one().customGET(name + '.json').then(function(data) {
      $scope.projects = data.projects;
      $location.path('/explore');
    });
  };

};