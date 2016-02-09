!function(angular){
    var malariaApp = angular.module("malariaApp", ['ngRoute', 'maUrls', 'malariaCtrls', 'maFilters']);

    malariaApp.config(['$routeProvider', 'maUrls', function($routeProvider, maUrls) {
        $routeProvider.when('/', {
            templateUrl: maUrls['dashboard'],
            controller: 'DashboardCtrl',
        }).otherwise({
            redirectTo: '/',
        });
    }]);
}(angular);
