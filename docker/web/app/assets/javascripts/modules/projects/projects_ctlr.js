this.ProjectsCtlr = function($scope, $location, Project, $routeParams, $mdDialog) {

  $scope.fetchProject = function(id) {
    if (id) {
      Project.one(id).get().then(function(data) {
        $scope.project = data;
      });
    }
  };

  $scope.saveProject = function(json) {
    Project.post({'project' : json}).then(function(data) {
      $scope.project = data;

      $mdDialog.hide();

      $location.path("/projects/" + $scope.project.id);
    });
  };

  $scope.toggleFollow = function() {
    if ($scope.project.following) {
      Project.one($scope.project.id).unfollow();
    } else {
      Project.one($scope.project.id).follow();
    }

    $scope.project.following = !$scope.project.following;
  };

  $scope.nextState = function() {
    Project.one($scope.project.id).nextState().then(function(data) {
      $scope.project = data;
    });
  };

  $scope.cancelState = function() {
    Project.one($scope.project.id).cancelState().then(function(project) {
      $scope.project = project;
    });
  };

  $scope.hideProjectForm = function() {
    $mdDialog.hide();

    return true;
  };

  if ($routeParams.id) {
    $scope.fetchProject($routeParams.id);
  }
};