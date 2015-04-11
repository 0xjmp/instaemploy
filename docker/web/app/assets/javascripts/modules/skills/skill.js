this.Skill = function(Restangular) {
  return Restangular.withConfig(function(config) {
    config.addElementTransformer('skills', function(skill) {
      skill.addRestangularMethod('create_email_alert', 'post', 'alerts');

      return skill;
    });
  }).service('skills');
};