this.Config = function($routeProvider, $locationProvider, $httpProvider, $provide, RestangularProvider, $mdThemingProvider) {
  $locationProvider.html5Mode(true);

  RestangularProvider.setBaseUrl('/api/v1/');
  RestangularProvider.setDefaultHeaders({
    'Content-Type': 'application/json; charset=utf-8'
  });
  RestangularProvider.setRequestSuffix('.json');

  $routeProvider
    .when('/', {
      templateUrl: 'welcome.html',
      controller: this.SearchCtlr
    })
    .when('/explore', {
      templateUrl: 'explore.html',
      controller: this.ExploreCtlr
    })
    .when('/projects/new', {
      templateUrl: 'project-form.html',
      controller: this.ProjectsCtlr
    })
    .when('/projects/:id', {
      templateUrl: 'project.html',
      controller: this.ProjectsCtlr
    })
    .when('/users/sign_in', {
      templateUrl: 'sign-in.html'
    })
    .when('/users/sign_up', {
      templateUrl: 'sign-up.html'
    })
    .when('/users/:id', {
      templateUrl: 'user.html'
    })
    .when('/users', {
      templateUrl: 'user.html'
    });

  $mdThemingProvider.theme('default')
    .primaryPalette('indigo')
    .accentPalette('light-blue');
};