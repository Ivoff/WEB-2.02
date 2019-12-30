<%-- 
    Document   : forum
    Created on : Dec 24, 2019, 2:17:01 PM
    Author     : zilas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.css">
        <script src="resources/js/jquery-3.4.1.min.js"></script>        
        <title>Forum Form</title>
    </head>
    <body>
        <h1>Forum Form</h1>
        <div class="container">            
            <form action="forum" method="POST">                
                <div class="form-group">
                    <label for="input_name">Name</label>
                    <input class="form-control" type="text" name="input_name">
                </div>

                <div class="form-group">
                    <label for="input_description">Description</label>
                    <textarea cols="40" rows="6" class="form-control" name="input_description"></textarea>
                    <small class="badge badge-warning form-text text-white">can be empty</small>
                </div>               
                
                <!--TODO: Images upload-->
                
                <button class="btn btn-primary" type="submit">Send</button>
            </form>            
        </div>
    </body>
</html>
