! function(angular) {
    var ENDPOINT_URL = '/api/user';
    
    var user = angular.module('maServices', []);
    user.factory('maUser', ['$http', function($http) {
        return $http.get(ENDPOINT_URL).then(function(response) {
            return response.data;
        }).catch(function(error) {
            console.log(error);
            throw error;
        });
    }]);
}(angular);
