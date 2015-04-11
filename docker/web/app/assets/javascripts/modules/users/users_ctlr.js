this.UsersCtlr = function($scope, $routeParams, User, $location, $mdDialog, Skill) {
  $scope.isReady = false;
  $scope.alerted = false;

  $scope.tabs = ['Recent', 'Popular', 'Interesting'];
  $scope.currentTab = angular.lowercase($scope.tabs[0]);

  $scope.fetchUser = function() {
    if (!$scope.user) {
      User.one($routeParams.id).get().then(function(data) {
        $scope.user = data;
      });
    }
  };

  $scope.registerUser = function(user) {
    User.post({'user': user}).then(function(data) {
      $scope.user = data;
      $location.path('/users');
    });
  };

  $scope.updateUser = function(user) {
    user.put().then(function(data) {
      $scope.user = data;
      $scope.hideDialog();
    });
  };

  $scope.changeProjectTab = function(tab) {
    $scope.currentTab = angular.lowercase(tab);
  };

  $scope.login = function(user) {
    User.one().login({user: user}).then(function(data) {
      $scope.fetchUser();
      $location.path('/users');
    });
  };

  $scope.loginWithGitHub = function() {
    $location.path('/auth/github');
    $location.reload();
    return;
    User.one().oauth_github().then(function(data) {
      $scope.user = data.info;
    });
  };

  $scope.logout = function() {
    User.one().logout().then(function() {
      $scope.user = undefined;
      $location.path('/');
    });
  };

  $scope.createEmailAlert = function(alert) {
    Skill.one().create_email_alert({'alert': alert}).then(function(data) {
      $scope.alerted = data.success;

      $scope.hideDialog();
    }, function() {
      $scope.hideDialog();
    });
  };

  $scope.hideDialog = function() {
    $mdDialog.hide();

    return true;
  };
};