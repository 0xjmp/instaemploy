describe('ExploreController', function() {

  beforeEach(module('instaemploy'));
  beforeEach(module('explore'));

  var $httpBackend, $scope, exploreController;

  beforeEach(inject(function(_$httpBackend_, $rootScope, _$controller_, _$resource_, Project, Restangular) {
    $httpBackend = _$httpBackend_;

    $scope = $rootScope;
    var $controller = _$controller_;

    projects = [Restangular.one('projects', 1), Restangular.one('projects', 2)];
    projectsMock = {projects: projects};

    // Default HTTP
    $httpBackend.whenGET('/api/v1/explore.json').respond(projectsMock);

    exploreController = function() {
      return $controller(this.ExploreCtlr, { '$scope' : $scope });
    };
  }));

  it('$scope.explore', function() {
    $httpBackend.expectGET('/api/v1/explore.json').respond(projectsMock);
    exploreController();

    $scope.explore();
    $httpBackend.flush();

    expect($scope.projects).toEqual(projects);
  });

});