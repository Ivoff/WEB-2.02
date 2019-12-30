<%-- 
    Document   : login
    Created on : Dec 27, 2019, 8:02:23 PM
    Author     : zilas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <t:header></t:header>
        <link rel="stylesheet" type="text/css" href="resources/css/login.css">
        <title>Login Page</title>
    </head>
    <body>
        <div class="container">
            <div class="row custom-row justify-content-center align-items-center">                
                <div class="p-5 col-6 custom-col">
                    <h3 class="pl-3 pt-1">Forum</h3>
                    <form action="login" method="POST" class="p-3">
                        
                        <input type="hidden" name="login_flag" value="not_null">
                        
                        <div class="form-group">
                            <label for="email_login">Email</label>
                            <input class="form-control" type="email" name="email_login" id="email_login">
                        </div>

                        <div class="form-group">
                            <label for="password_login">Password</label>
                            <input class="form-control" type="password" name="password_login" id="password_login">
                        </div>

                        <br/>

                        <div class="row justify-content-between">
                            <div class="col-4">
                                <button class="btn btn-primary btn-block" type="submit">send</button>
                            </div>
                            <div class="col-5">
                                <p class="">New around? <a href="user">Sign up here</a></p>
                            </div>                            
                        </div>
                    </form>                        
                </div>
            </div>
        </div>
    </body>
</html>
