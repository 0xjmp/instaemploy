this.ExploreCtlr = function($scope, Search, Explore, $location, Alert) {
  SearchCtlr.call(this, $scope, Search);

  $scope.explore = function() {
    Explore.one().get().then(function(data) {
      $scope.projects = data.projects;
    });
  };

};