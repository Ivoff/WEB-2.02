<%-- 
    Document   : User
    Created on : Nov 16, 2019, 4:23:41 PM
    Author     : zilas
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="Entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.css">
        <script src="resources/js/jquery-3.4.1.min.js"></script>        
        <title>User Form</title>
    </head>
    <body>        
        <div class="container-fluid shadow-sm bg-light">
            <div class="row">
                <div class="col">
                    <h1 class="display-4">User Form</h1>                
                </div>
                <div class="col">
                    <form class="form-inline mt-3 pt-1 d-flex justify-content-end" method="POST" action="user">
                        <input type="hidden" name="search" value="not_null">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="query">
                        <button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="container">
            <br/>
            
            <div class="btn-group">
                <button type="button" class="btn btn-secondary" id="create">Add</button>
                <button type="button" class="btn btn-primary" id="list">DashBoard</button>
                <button type="button" class="btn btn-primary" id="test">Login</button>                
            </div>                        
                        
            <%
                if (request.getAttribute("dashboard") != null) {
            %>                    
            <script>
                $(document).ready(function () {
                    $('#list').removeClass('btn-primary');
                    $('#list').addClass('btn-secondary');
                    $('#create').removeClass('btn-secondary');
                    $('#create').addClass('btn-primary');                    
                    $('#user_table').removeClass('d-none');
                    $('#user_form').addClass('d-none');
                    $('#user_test').addClass('d-none');
                });
            </script>
            <%
                }
            %>
                        

            <%
                User selectedUser = new User();
                String flag = null;
                if (request.getAttribute("selected_user") != null) {
                    flag = "update";
                    selectedUser = (User) request.getAttribute("selected_user");
                } else {
                    flag = "insertion";
                }
            %>

            <br/>
            <br/>

            <%
                if (request.getAttribute("error") != null) {%>
            <div class="alert alert-warning" role="alert">
                <%= request.getAttribute("error")%>
            </div>
            <%}
            %>

            <form action="user" method="POST" id="user_form">
                <div class="form-group">

                    <input type="hidden" name="flag" value="<%= flag%>">

                    <%
                        if (flag.equals("update")) {
                    %>
                    <input type="hidden" name="user_id" value="<%= selectedUser.getId()%>">
                    <%
                        }
                    %>

                    <div class="form-group" id="name_group">
                        <label id=label_name for="input_name">Name</label>
                        <%
                            String name = flag.equals("update") ? selectedUser.getName() : "";
                        %>
                        <input class="form-control" id="input_name" name="input_name" type="text" required value="<%= name%>">
                    </div>

                    <div class="form-group" id="email_group">
                        <label id=label_email for="input_email">Email</label>
                        <%
                            String email = flag.equals("update") ? selectedUser.getEmail() : "";
                        %>
                        <input class="form-control" id="input_email" name="input_email" type="email" required value="<%= email%>">
                    </div>

                    <div class="form-group" id="birthday_group">
                        <label id="label_birthday" for="input_birthday">Birthday</label>                        
                        <input class="form-control" id="input_birthday" name="input_birthday" type="date" required></input>
                    </div>

                    <div class="form-group" id="password_group">
                        <label id=label_password for="input_password">Password</label>                        
                        <input class="form-control" id="input_password" name="input_password" type="password" required>
                    </div>

                    <div class="form-group" id="confirm_group">
                        <label id=label_confirm for="input_confirm">Confirm Password</label>
                        <input class="form-control" id="input_confirm" name="input_confirm" type="password" required>
                    </div>

                    <button type="submit" class="btn btn-primary">Send</button>                                       
                </div>
            </form>            
            <div class="d-none" id="user_table">
                <table class="table">
                    <thead>
                        <tr>                        
                            <th>Name</th>
                            <th>Email</th>
                            <th>Birthday</th>
                            <th>Hash</th>
                            <th>Created At</th>
                            <th>Updated At</th>
                            <th colspan="2"></th>
                        <tr>
                    </thead>
                    <tbody>
                        <%
                            List<User> list;
                            list = (List<User>) request.getAttribute("all");
                        %>
                        <%
                            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                            DateTimeFormatter offsetDateFormat = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
                            for (User user : list) {
                        %>
                        <tr>

                            <td><%= user.getName()%></td>
                            <td><%= user.getEmail()%></td>
                            <td><%= dateFormat.format(user.getBirthday())%></td>
                            <td>
                                <div style="width: 100px; height: 50px; overflow: auto">
                                    <%= user.getHashPass()%>
                                </div>
                            </td>
                            <td><%= offsetDateFormat.format(user.getCreatedAt())%></td>
                            <td><%= offsetDateFormat.format(user.getUpdatedAt())%></td>
                            <td>
                                <a href="user?edit=<%= user.getId()%>">
                                    <button class="btn btn-info">
                                        edit
                                    </button>
                                </a>
                            </td>
                            <td>
                                <a href="user?destroy=<%= user.getId()%>">
                                    <button class="btn btn-danger">
                                        destroy
                                    </button>
                                </a>
                            </td>
                        </tr>                   
                        <%}%>                    
                    </tbody> 
                    <p class="text-right"><a href="user?reset=true"><button type="button" class="btn btn-warning">Reset</button></a></p>
                </table>
            </div>
                
            <%                
                String message = "";
                if(request.getAttribute("status") == null){                    
                    %>
                    <script>
                        $(document).ready(function(){
                            $('#login').attr('id', 'user_test');
                            $('#logged').addClass('d-none');
                        });
                    </script>
                    <%
                }else if(request.getAttribute("status").equals("NOT-OK")){
                    %>
                    <script>
                        $(document).ready(function(){
                            $('#login').attr('id', 'user_test');
                            $('#logged').addClass('d-none');
                        });
                    </script>
                    <%
                    message = "Email ou senha incompativeis";
                }else{
                    %>
                    <script>
                        $(document).ready(function(){
                            $('#logged').addClass('d-none');
                            $('#logged').attr('id', 'user_test');                            
                        });
                    </script>
                    <%
                }
            %>
                
            <div class="container d-none" id="login">
                <br/>
                <br/>
                <br/>
                <br/>
                <form class="d-flex justify-content-center" method="POST" action="user">                    
                    <div class="form-group shadow p-3">
                        <h4 class="font-weight-light text-center">Fake login</h4>
                        <input type="hidden" name="login" value="not_null">                        
                        <input type="email" class="form-control" placeholder="email" name="user_email"></input>
                        <input type="password" class="form-control mt-1" placeholder="password" name="user_pass"></input>                        
                        <p class="text-center"><button class="btn btn-primary mt-3">send</button></p>
                        <p class="text text-center"><%= message%></p>
                        <small class="badge badge-danger form-text text-white">Espaços dão ruim</small>
                    </div>
                </form>
            </div>
                            
            <div class="container" id="logged">
                <div class="d-flex justify-content-center text-center">
                    <div class="container">
                        <h1 class="display-1">Voce esta tecnicamente logado</h1>
                        <br/>
                        <br/>
                        <a href="user?logout=true">
                            <button class="btn btn-outline-danger btn-lg">Logout</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>                
        <script>
            $(document).ready(function () {
                $('#list').on('click', function () {
                    $(this).removeClass('btn-primary');
                    $(this).addClass('btn-secondary');
                    $('#user_table').removeClass('d-none');                    
                    if($('#create').hasClass('btn-secondary')){
                        $('#create').removeClass('btn-secondary');
                        $('#create').addClass('btn-primary');
                        $('#user_form').addClass('d-none');
                    }
                    else{
                        $('#test').removeClass('btn-secondary');
                        $('#test').addClass('btn-primary');
                        $('#user_test').addClass('d-none');
                    }
                });

                $('#create').on('click', function () {
                    $(this).removeClass('btn-primary');
                    $(this).addClass('btn-secondary');
                    $('#user_form').removeClass('d-none');                    
                    if($('#list').hasClass('btn-secondary')){
                        $('#list').removeClass('btn-secondary');
                        $('#list').addClass('btn-primary');
                        $('#user_table').addClass('d-none');
                    }
                    else{
                        $('#test').removeClass('btn-secondary');
                        $('#test').addClass('btn-primary');
                        $('#user_test').addClass('d-none');
                    }
                });
                
                $('#test').on('click', function () {
                    $(this).removeClass('btn-primary');
                    $(this).addClass('btn-secondary');
                    $('#user_test').removeClass('d-none');                    
                    if($('#create').hasClass('btn-secondary')){
                        $('#create').removeClass('btn-secondary');
                        $('#create').addClass('btn-primary');
                        $('#user_form').addClass('d-none');
                    }
                    else{
                        $('#list').removeClass('btn-secondary');
                        $('#list').addClass('btn-primary');
                        $('#user_table').addClass('d-none');
                    }
                });
            });
        </script>
    </body>
</html>
