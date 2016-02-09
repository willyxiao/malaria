! function(angular) {

    var malariaCtrls = angular.module('malariaCtrls', ['maDirectives']);
    malariaCtrls.controller("DashboardCtrl", ["$scope", "$http", function($scope, $http) {
        $scope.startDate = new Date("Mon Apr 11 2016 03:00:00 GMT-0500 (EST)");
        
        
        
    }]);
}(angular);
