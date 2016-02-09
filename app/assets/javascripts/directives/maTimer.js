!function(angular) {
    
    var maDirectives = angular.module("maDirectives", ['maUrls', 'maFilters']);
    
    maDirectives.directive('maTimer', ['maUrls', '$timeout', function(maUrls, $timeout) {
        return {
            scope: {
                date: '=maTimer',                
            },
            templateUrl: maUrls['timer'],
            link: function(scope, el, attrs) {
                function updateTime() {
                    var datediff = scope.date - new Date();
                    scope.days = Math.floor(datediff / (1000*60*60*24));
                    scope.hours = Math.floor(datediff / (1000*60*60)) % 24;
                    scope.minutes = Math.floor(datediff / (1000 * 60)) % 60;
                    scope.seconds = Math.floor(datediff / 1000) % 60;
                    $timeout(updateTime, 1000);                    
                }
                updateTime();
            },
        };
    }]);
}(angular);
