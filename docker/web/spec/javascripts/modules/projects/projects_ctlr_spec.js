describe('ProjectsController', function() {

  beforeEach(module('instaemploy'));
  beforeEach(module('projects'));

  var $httpBackend, $scope, projectsController, project, projectMock, $location, projects, projectsMock;

  beforeEach(inject(function(_$httpBackend_, $rootScope, $controller, _$location_, Restangular) {
    projects = Restangular.all('projects')
    projectsMock = {projects: [projectMock, projectMock]};

    user = Restangular.one('users', 1);
    user.projects = {
      "popular": projects
    };

    project = Restangular.one('projects', 1);
    project.user = user;
    projectMock = {project: {id: 1, state: 'uncompleted', user: {id: 1}}};

    $httpBackend = _$httpBackend_;
    $location = _$location_;
    $scope = $rootScope;

    projectsController = function() {
      return $controller(this.ProjectsCtlr, { '$scope' : $scope });
    };
  }));

  describe('$scope.saveProject', function() {
    it('should create a project', function() {
      $httpBackend.expectPOST('/api/v1/projects.json').respond(projectMock);
      projectsController();

      $scope.saveProject(project);
      $httpBackend.flush();

      expect($scope.project).toBeDefined();
      expect($location.path()).toEqual('/projects/' + project.id);
    });
  });

  describe('$scope.fetchProject', function() {
    it('should get a project', function() {
      $httpBackend.expectGET('/api/v1/projects/' + project.id + '.json').respond(projectMock);
      projectsController();

      $scope.fetchProject(project.id);
      $httpBackend.flush();

      expect($scope.project.id).toEqual(project.id);
    });
  });

  describe('$scope.toggleFollow', function() {
    it('should follow', function() {
      projectMock.following = true;
      $httpBackend.expectPUT('/api/v1/projects/' + project.id + '/follow.json').respond(projectMock);
      projectsController();
      $scope.project = project;

      $scope.toggleFollow();
      $httpBackend.flush();

      expect($scope.project.following).toBe(true);
    });
    it('should unfollow', function() {
      project.following = true;
      projectMock.following = false;
      $httpBackend.expectDELETE('/api/v1/projects/' + project.id + '/follow.json').respond(projectMock);

      projectsController();
      $scope.project = project;

      $scope.toggleFollow();
      $httpBackend.flush();

      expect($scope.project.following).toBe(false);
    });
  });

  describe('$scope.nextState', function() {
    it('should advance the state', function() {
      projectMock.project.state = 'started';
      $httpBackend.expectPUT('/api/v1/projects/' + project.id + '/next.json').respond(projectMock);
      projectsController();
      $scope.project = project;

      $scope.nextState();
      $httpBackend.flush();

      expect($scope.project.state).toEqual('started');
    });
  });

  describe('$scope.cancelState', function() {
    it('should cancel the state', function() {
      $httpBackend.expectPUT('/api/v1/projects/' + project.id + '/cancel.json').respond(projectMock);
      projectsController();
      $scope.project = project;
      $scope.project.state = 'started';

      $scope.cancelState();
      $httpBackend.flush();

      expect($scope.project.state).toEqual('uncompleted');
    });
  });

  it('$scope.hideProjectForm', function() {
    projectsController();

    expect($scope.hideProjectForm()).toBe(true);
  });
});