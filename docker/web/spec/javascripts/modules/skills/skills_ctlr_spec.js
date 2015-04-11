describe('SkillsController', function() {

  beforeEach(module('instaemploy'));
  beforeEach(module('skills'));

  var $httpBackend, $scope, skillsController, $location, $routeParams, skills, skillsMock;

  beforeEach(inject(function(_$httpBackend_, $rootScope, _$controller_, _$resource_, _$location_, _$routeParams_, Restangular, Skill) {
    $httpBackend = _$httpBackend_;
    $routeParams = _$routeParams_;

    $location = _$location_;
    $scope = $rootScope;
    var $controller = _$controller_;

    skillsController = function() {
      return $controller(this.SkillsCtlr, { '$scope' : $scope });
    };

    skills = [Skill.one(1), Skill.one(2)];
    skillsMock = {projects: [], skills: skills};
  }));

  describe('$scope.fetchSkill', function() {
    it('should get a skill', function() {
      var name = "test";
      $httpBackend.expectGET('/api/v1/skills/' + name + '.json').respond(skillsMock);
      skillsController();

      $scope.fetchSkill(name);
      $httpBackend.flush();

      expect($scope.projects).toEqual(skillsMock.projects);
      expect($location.path()).toEqual('/explore');
    });
  });
});