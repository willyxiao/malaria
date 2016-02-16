! function(angular) {
    var ENDPOINT_URL = '/api/user'

    var malariaCtrls = angular.module('malariaCtrls', ['maDirectives', 'maServices']);
    malariaCtrls.controller("DashboardCtrl", ["$scope", "$http", "maUser", function($scope, $http, maUser) {
        $scope.startDate = new Date("Mon Apr 11 2016 03:00:00 GMT-0500 (EST)");
        $http.get(ENDPOINT_URL).then(function(response) {
            $scope.user = response.data;
        }).catch(function(err) {
            console.error(err);
        });
    }]);
}(angular);
