!function(angular){
    var registrationApp = angular.module("registrationApp", ['ngRoute','ng-rails-csrf', 'maUrls']);
    registrationApp.config(['$routeProvider', 'maUrls', function($routeProvider, maUrls) {
        $routeProvider.when('/', {
            templateUrl: maUrls['register'],
            controller: 'RegistrationCtrl',
        })
    }]);
    
    registrationApp.controller("RegistrationCtrl", ["$scope", "$http", function($scope, $http) {
        $scope.hello = 'hello';
        // this.hello = 'hi';
        // this.step = 0;
        // this.increment = function() {
        //     this.step++;
        //     console.log(this.step);
    }]);
}(angular);
