this.SearchCtlr = function($scope, Search, $mdDialog) {
  $scope.loading = false;

  $scope.searchActive = false;

  $scope.query = function(text) {
    var query;
    if ($scope.searchScope) {
      query = $scope.searchScope + "/" + text + ".json";
    } else {
      query = text + '.json';
    }

    $scope.loading = true;
    Search.one().customGET(query).then(function(data) {
      $scope.projects = data.projects;

      $scope.loading = false;
    }, function() {
      $scope.loading = false;
    });
  };

  $scope.toggleSearch = function() {
    $scope.searchActive = !$scope.searchActive;
  };

  $scope.showEmailAlertDialog = function(skills) {
    $scope.alert = {skill_list: skills};

    $mdDialog.show({
      controller: UsersCtlr,
      templateUrl: 'email-alert.html',
      scope: $scope
    });

    return true;
  };
};