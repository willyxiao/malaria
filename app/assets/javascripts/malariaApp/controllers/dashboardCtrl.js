! function(angular) {

    var malariaCtrls = angular.module('malariaCtrls', ['maDirectives', 'maServices']);
    malariaCtrls.controller("DashboardCtrl", ["$scope", "$http", "maUser", function($scope, $http, maUser) {
        $scope.startDate = new Date("Mon Apr 11 2016 03:00:00 GMT-0500 (EST)");
        maUser.then(function(user) {
            $scope.user = user;
            debugger;
        });
        
        
    }]);
}(angular);
