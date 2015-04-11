this.Run = function(Restangular, Alert, $location) {
  Restangular.setErrorInterceptor(function(response, deferred, responseHandler) {
    data = response.data;

    switch(response.status) {
      case 401:
        error = data.errors ? data.errors.join() : data.error;
        Alert.add("error", error);
        $location.path('/users/sign_up');
        return false;
      case 403:
        Alert.add('error', "You are not allowed to do this");
        return false;
      case 422:
        message = '';
        if (data.errors) {
          for (var key in data.errors) {
            message = data.errors[key]
          }
        } else {
          message = data.error;
        }
        return false;
      case 500:
        Alert.add("error", "Something went wrong. Please try again later.");
        return false;
      default:
        break;
    }

    return true;
  });
};