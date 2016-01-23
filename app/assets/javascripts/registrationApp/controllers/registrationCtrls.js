! function(angular) {
    var HASH_CHECK_URL = ? ?

    var registrationCtrls = angular.module('registrationCtrls', []).controller()

    registrationCtrls.controller("RegistrationCtrl", ["$scope", "$http", "$routeParams", function($scope, $http, $routeParams) {
        $scope.hash = $routeParams.hash;
        $scope.data = undefined;
        $scope.getHashDataP = getHashDataP;

        function resetPage() {
            $scope.hash = undefined;
            $scope.data = undefined;
        }

        function getHashDataP() {
            if (!$scope.hash) {
                resetPage();
            }

            $http.get(HASH_CHECK_URL, {
                hash: $scope.hash,
            }).then(function(response) {
                if (response.data && response.data.success) {
                    $scope.community = response.data.community;
                }
                else {
                    resetPage();
                    $scope.error = response.data.error;
                }
            }).catch(function(err) {
                console.error(err);
                resetPage();
            })
        }
    }]);
}(angular);
