! function(angular) {
    var HASH_CHECK_URL = '/register/check/'

    var registrationCtrls = angular.module('registrationCtrls', []).controller()

    registrationCtrls.controller("RegistrationCtrl", ["$scope", "$http", "$routeParams", "$timeout", function($scope, $http, $routeParams, $timeout) {
        $scope.hash = filterHash($routeParams.hash);
        $scope.community = undefined;
        $scope.processingHash = false;
        $scope.getHashDataP = getHashDataP;
        $scope.processHash = processHash;

        if ($routeParams.hash) {
            $scope.getHashDataP();
        }
        
        function processHash() {
            if ($scope.hash && $scope.hash.length == 4) {
                $scope.getHashDataP(); 
            }
        }
        
        function filterHash(hash) {
            return hash 
                ? String(hash).replace(/[^A-Za-z0-9]/g, '')
                : undefined;
        }

        function getHashDataP() {
            $scope.processingHash = true;
            $http.get(HASH_CHECK_URL + $scope.hash).then(function(response) {
                if (response.data && response.data.success) {
                    $scope.community = response.data.community;
                }
                else {
                    $scope.error = $scope.hash;
                    console.error($scope.hash);
                }
            }).catch(function(err) {
                $scope.error = err;
                console.error(err);
            }).then(function() {
                $timeout(function() {
                    $scope.processingHash = false;                     
                }, 1000);
            });
        }
    }]);
}(angular);
