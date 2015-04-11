this.NavigationCtlr = function($scope, $routeParams, User, $location, $mdDialog) {
  UsersCtlr.call(this, $scope, $routeParams, User, $location, $mdDialog);

  $scope.currentItem = 0;
  $scope.sideMenuShowing = false;

  $scope.toggleSideMenu = function() {
    $scope.sideMenuShowing = !$scope.sideMenuShowing;
  };

  $scope.selectMenuItem = function(index) {
    $scope.toggleSideMenu();
    $scope.currentItem = index;
  };

  $scope.showProjectDialog = function() {
    $mdDialog.show({
      controller: ProjectsCtlr,
      templateUrl: 'project-form.html'
    });

    return true;
  };

  $scope.showEditUserDialog = function() {
    $mdDialog.show({
      controller: UsersCtlr,
      templateUrl: 'user-edit.html',
      scope: $scope
    });

    return true;
  };
};