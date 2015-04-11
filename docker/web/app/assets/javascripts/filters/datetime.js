this.Datetime = function($filter) {
  return function(input) {
    return $filter('date')(new Date(input), "MMM dd, yyyy 'at' HH:mm a");
  };
};