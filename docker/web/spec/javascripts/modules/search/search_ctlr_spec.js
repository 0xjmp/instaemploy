describe('SearchController', function() {

  beforeEach(module('instaemploy'));
  beforeEach(module('search'));

  var $httpBackend, $scope, searchController, $location, $routeParams;

  beforeEach(inject(function(_$httpBackend_, $rootScope, _$controller_, _$resource_, _$location_, _$routeParams_, Restangular) {
    $httpBackend = _$httpBackend_;
    $routeParams = _$routeParams_;

    $location = _$location_;
    $scope = $rootScope;
    var $controller = _$controller_;

    searchController = function() {
      return $controller(this.SearchCtlr, { '$scope' : $scope });
    };

    projects = [Restangular.one('projects', 1), Restangular.one('projects', 2)];
    projectsMock = {projects: projects};

    $httpBackend.whenGET('/api/v1/search/projects/Project.json').respond(projectsMock);
  }));

  describe('$scope.query', function() {
    describe('while not scoped', function() {
      it('should return results', function() {
        $httpBackend.expectGET('/api/v1/search/Project.json').respond(projectsMock);

        searchController();

        $scope.query("Project");
        $httpBackend.flush();

        expect($scope.projects).toEqual(projects);
      });
    });
    it('should return results while project scoped', function() {
      $httpBackend.expectGET('/api/v1/search/projects/Project.json');

      searchController();
      $scope.searchScope = "projects";

      $scope.query("Project");
      $httpBackend.flush();

      expect($scope.projects).toEqual(projects);
    });
  });
  describe('$scope.toggleSearchActive', function() {
    it('should toggle searchActive', function() {
      searchController();
      $scope.toggleSearch();
      expect($scope.searchActive).toBe(true);
    });
  });

  it('$scope.showEmailAlertDialog', function() {
    searchController();

    var skill_list = 'ruby';
    expect($scope.showEmailAlertDialog(skill_list)).toBe(true);
  });
});