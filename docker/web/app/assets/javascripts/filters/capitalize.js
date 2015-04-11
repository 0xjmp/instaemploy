this.Capitalize = function() {
  return function(input, all) {
    if (!!input) {
      return input.replace(/([^\W_]+[^\s-]*) */g, function(txt) {
        return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
      });
    } else {
      return "";
    }
  };
};