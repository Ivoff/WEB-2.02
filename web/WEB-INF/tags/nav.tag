<%-- 
    Document   : nav
    Created on : Dec 27, 2019, 9:00:05 PM
    Author     : zilas
--%>

<%@tag description="navbar" pageEncoding="UTF-8"%>
<%@attribute name="currentPage" required="true" rtexprvalue="true" %>

<nav class="custom-navbar navbar navbar-expand-lg navbar-dark">
    <!--<a class="navbar-brand" href="">Forum</a>-->
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
<!--        <ul class="navbar-nav mr-auto">            
            <li class="nav-item">
                <a class="nav-link" href="forum">Forums</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="post">Posts</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="user">User</a>
            </li>
        </ul>-->
        <a href="user" class="btn btn-outline-secondary text-monospace rounded-0">
            USERS
        </a>
        <a href="post" class="btn btn-outline-secondary text-monospace rounded-0">
            POSTS
        </a>
        <a href="forum" class="btn btn-outline-secondary text-monospace rounded-0">
            FORUMS
        </a>
    </div>
</nav>