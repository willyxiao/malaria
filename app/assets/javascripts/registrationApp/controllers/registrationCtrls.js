! function(angular) {
    var HASH_CHECK_URL = '/register/check/'

    var registrationCtrls = angular.module('registrationCtrls', []).controller()

    registrationCtrls.controller("RegistrationCtrl", ["$scope", "$http", "$routeParams", function($scope, $http, $routeParams) {
        $scope.hash = filterHash($routeParams.hash);
        $scope.community = undefined;
        $scope.getHashDataP = getHashDataP;
        $scope.fbLogin = fbLogin;
        $scope.getHashDataP();

        function fbLogin() {
            console.log('hi');
        }
        
        function filterHash(hash) {
            return String(hash).replace(/[^A-Za-z0-9]/g, '');
        }        

        function resetPage() {
            $scope.hash = undefined;
            $scope.community = undefined;
        }

        function getHashDataP() {
            if (!$scope.hash) {
                resetPage();
            }
            $http.get(HASH_CHECK_URL + $scope.hash).then(function(response) {
                if (response.data && response.data.success) {
                    $scope.community = response.data.community;
                }
                else {
                    $scope.error = $scope.hash;
                    resetPage();
                }
            }).catch(function(err) {
                console.error(err);
                resetPage();
            })
        }
    }]);
}(angular);
