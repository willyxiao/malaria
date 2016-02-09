! function(angular) {
    var user = angular.module('maFilters', []);
    user.factory('maUser', ['$http', function($http) {
        return $http.get().then(function(response) {
            return response.data;
        }).catch(function(error) {
            console.log(error);
            throw error;
        });
    }]);
}(angular);
