!function($){
    $('body').prepend('<div id="fb-root"></div>')
    
    $.ajax({
        url: "//connect.facebook.net/en_US/all.js",
        dataType: 'script',
        cache: true,
    })
}(jQuery)

!function(){
    window.fbAsyncInit = function() {
        FB.init({appId: '1520222368275265', cookie: true})

        $('#sign_in').click(function(e){
            e.preventDefault()
            FB.login(function(response){
                if(response.authResponse) {
                    window.location = '/auth/facebook/callback'
                }
            })
        })
        
        $("#sign_out").click(function(e){
            FB.getLoginStatus(function(response){
                if(response.authResponse){
                    FB.logout();
                }
            });            
        });
    }
}
