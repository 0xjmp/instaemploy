describe('NavigationController', function() {

  beforeEach(module('instaemploy'));
  beforeEach(module('navigation'));

  var $httpBackend, $scope, navigationController, userMock, $location;

  beforeEach(inject(function(_$httpBackend_, $rootScope, _$controller_, _$resource_, Restangular, _$location_) {
    $httpBackend = _$httpBackend_;
    $location = _$location_;

    $scope = $rootScope;
    var $controller = _$controller_;

    navigationController = function() {
      return $controller(this.NavigationCtlr, { '$scope' : $scope });
    };
  }));

  describe('$scope.toggleSideMenu', function() {
    it('should toggle the menu', function() {
      navigationController();

      $scope.toggleSideMenu();

      expect($scope.sideMenuShowing).toBe(true);
    });
  });

  describe('$scope.selectMenuItem', function() {
    it('should set currentItem', function() {
      navigationController();

      var index = 2;
      $scope.selectMenuItem(index);

      expect($scope.currentItem).toEqual(index);
      expect($scope.sideMenuShowing).toBe(true);
    });
  });

  it('$scope.showProjectDialog', function() {
    navigationController();
    expect($scope.showProjectDialog()).toBe(true);
  });

  it('$scope.showEditUserDialog', function() {
    navigationController();
    expect($scope.showEditUserDialog()).toBe(true);
  });
});