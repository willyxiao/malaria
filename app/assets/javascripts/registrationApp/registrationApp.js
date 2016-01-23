!function(angular){
    var registrationApp = angular.module("registrationApp", ['ngRoute', 'maUrls', 'registrationCtrls']);

    registrationApp.config(['$routeProvider', 'maUrls', function($routeProvider, maUrls) {
        $routeProvider.when('/', {
            templateUrl: maUrls['register'],
            controller: 'RegistrationCtrl',
        }).when('/:hash', {
            templateUrl: maUrls['register'],
            controller: 'RegistrationCtrl',
        }).otherwise({
            redirectTo: '/',
        })
    }]);

}(angular);
