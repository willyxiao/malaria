!function(angular){
    var registrationApp = angular.module("registrationApp", []);
    registrationApp.controller("registrationCtrl", ["$http", function($http){
        this.hello = 'hi';
        this.step = 0;
        this.increment = function() {
            this.step++;
            console.log(this.step);
        }
    }]);
}(angular);
