describe('UsersController', function() {

  beforeEach(module('instaemploy'));
  beforeEach(module('users'));

  var $httpBackend, $scope, usersController, userMock, $location, $routeParams, projects, projectsMock;

  beforeEach(inject(function(_$httpBackend_, $rootScope, _$controller_, _$resource_, _$location_, _$routeParams_, User, Skill) {
    $httpBackend = _$httpBackend_;
    $routeParams = _$routeParams_;

    $location = _$location_;
    $scope = $rootScope;
    var $controller = _$controller_;

    usersController = function() {
      return $controller(this.UsersCtlr, { '$scope' : $scope });
    };

    authMock = {auth_token: 'ooooopretty'};

    user = User.one('users', 1);

    projects = [User.one('projects', 1), User.one('projects', 2)];
    projectsMock = {projects: projects};

    user.projects = projects;
    userMock = {user: user};

    skillMock = {projects: []};

    alert = Skill.one('users', 1);

    oauthMock = {uid: '1234567', provider: 'github', info: user};

    $httpBackend.whenGET('/api/v1/users.json').respond(userMock);
    $httpBackend.whenGET('/api/v1/users/' + user.id + '.json').respond(userMock);
    $httpBackend.whenPUT('/api/v1/users').respond(userMock);
  }));

  describe('$scope.fetchUser', function() {
    describe('while id passed', function() {
      it('should get a user', function() {
        usersController();
        $routeParams.id = user.id;

        $scope.fetchUser();
        $httpBackend.flush();

        expect($scope.user.id).toEqual(user.id);
      });
    });
    describe('while no id passed', function() {
      it('should get the current user', function() {
        $httpBackend.expectGET('/api/v1/users.json').respond(userMock);

        usersController();
        $scope.isReady = true;

        $scope.fetchUser();
        $httpBackend.flush();

        expect($scope.user.id).toEqual(user.id);
      });
    });
  });

  describe('$scope.registerUser', function() {
    it('should not register a user while invalid form', function() {
      usersController();

      $scope.registerUser(user);

      expect($scope.user).toBeUndefined();
    });
    it('should register a user', function() {
      $httpBackend.expectPOST('/api/v1/users.json').respond(userMock);
      usersController();

      $scope.isReady = true;
      $scope.registerUser(user);
      $httpBackend.flush();

      expect($scope.user.id).toEqual(user.id);
    });
  });

  describe('$scope.updateUser', function() {
    it('should update the user', function() {
      $httpBackend.expectPUT('/api/v1/users.json').respond(userMock);
      usersController();

      $scope.updateUser(user);
      $httpBackend.flush();

      expect($scope.user.id).toEqual(user.id);
    });
  });

  it('should have tabs', function() {
    usersController();
    expect($scope.tabs).toBeDefined();
  });

  describe('$scope.changeProjectTab', function() {
    it('should update projects', function() {
      usersController();
      user.projects = {
        "popular": projects
      };
      $scope.user = user;

      var tab = "Popular";
      $scope.changeProjectTab(tab);

      expect($scope.currentTab).toEqual(angular.lowercase(tab));
    });
  });

  describe('$scope.login', function() {
    it('should get an auth token', function() {
      $httpBackend.expectPOST('/api/v1/users/sign_in.json').respond(authMock);
      $httpBackend.expectGET('/api/v1/users.json').respond(userMock);

      usersController();
      $scope.login(user);
      $httpBackend.flush();

      expect($scope.user.id).toEqual(user.id);
      expect($location.path()).toEqual('/users');
    });
  });

  it('$scope.loginWithGitHub', function() {
    $httpBackend.expectGET('/api/v1/users/auth/github.json').respond(oauthMock);

    usersController();
    $scope.loginWithGitHub();
    $httpBackend.flush();

    expect($scope.user).toEqual(user);
  });

  describe('$scope.logout', function() {
    it('should log out the user', function() {
      $httpBackend.expectDELETE('/api/v1/users/sign_out.json').respond({});
      usersController();
      $scope.user = user;

      $scope.logout();
      $httpBackend.flush();

      expect($scope.user).toBeUndefined();
      expect($location.path()).toEqual('/');
    });
  });

  it('$scope.hideDialog', function() {
    usersController();
    expect($scope.hideDialog()).toBe(true);
  });

  it('$scope.createEmailAlert', function() {
    $httpBackend.expectPOST('/api/v1/skills/alerts.json').respond({success: true});

    usersController();
    $scope.createEmailAlert(alert);
    $httpBackend.flush();

    expect($scope.alerted).toBe(true);
  });
});