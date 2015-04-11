var cookie = '_call-of-code-app_session';

this.User = function(Restangular) {
  return Restangular.withConfig(function(config) {
    config.addResponseInterceptor(function(data) {
      if (data.auth_token) {
        Restangular.setDefaultHeaders({auth_token : data.auth_token});
      }

      if (data.user) {
        data = data.user;
      }

      return data;
    });

    config.addElementTransformer('users', false, function(user) {
      user.addRestangularMethod('logout', 'remove', 'sign_out');
      user.addRestangularMethod('login', 'post', 'sign_in');
      user.addRestangularMethod('oauth_github', 'post', 'auth/github');
      return user;
    });
  }).service('users');
};