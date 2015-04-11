this.Project = function(Restangular) {
  return Restangular.withConfig(function(config) {
    config.addResponseInterceptor(function(data) {
      if (data.project) {
        data = data.project;
      }

      return data;
    });

    config.addElementTransformer('projects', false, function(project) {
      project.addRestangularMethod('follow', 'put', 'follow');
      project.addRestangularMethod('unfollow', 'remove', 'follow');
      project.addRestangularMethod('nextState', 'put', 'next');
      project.addRestangularMethod('cancelState', 'put', 'cancel');
      return project;
    });
  }).service('projects');
};