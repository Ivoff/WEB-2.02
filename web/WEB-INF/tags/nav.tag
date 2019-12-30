<%-- 
    Document   : nav
    Created on : Dec 27, 2019, 9:00:05 PM
    Author     : zilas
--%>

<%@tag description="navbar" pageEncoding="UTF-8"%>
<%@attribute name="currentPage" required="true" rtexprvalue="true" %>

<nav class="custom-navbar navbar navbar-expand-lg navbar-dark">
    <a class="navbar-brand" href="">Forum</a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Browse
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <h4 class="dropdown-header text-dark">You're in ${currentPage}</h4>
                    <div class="dropdown-divider"></div>                                                                    
                    <a class="dropdown-item" href="#">Hot</a>                                                                                                       
                    <a class="dropdown-item" href="#">Top</a>
                </div>
            </li>            
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
    </div>
</nav>