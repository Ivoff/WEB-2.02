<%--
    Document   : forum
    Created on : Dec 24, 2019, 2:17:01 PM
    Author     : zilas
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entities.Forum"%>
<%@page import="Entities.User"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>

<t:page currentPage="forums/index">
    <jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/forum.css">
    </jsp:attribute>
    <jsp:body>        
        <div class="container-fluid">
            <div class="row mt-3">
                <div class="col-1"></div>
                <div class="col-3">                    
                    <div id="" class="custom-border pb-3 pr-3 pl-3 mb-3">
                        <div class="bg-dark-gray row row-col-1 pt-4">
                            <h5 class="font-weight-bold text-monospace pl-3">Recently created</h5>
                        </div>                    
                        <div class="row row-col-2 pt-2 pb-2">
                            <div class="ml-2 mr-2 w-100">
                                <c:forEach var="forum" items="${forums_recently}">
                                    <a href="forum?f=${forum.id}">
                                        <div class="overflow-auto row row-col-2 mt-3 ml-2 mr-2 border-bottom">
                                            <div class="col-3 my-2">
                                                <img src="${forum.imagePath}" alt="" height="55" width="55">
                                            </div>
                                            <div class="col-9">
                                                <p class="font-weight-bold text-monospace mt-3 mb-2 text-center d-block">      
                                                    ${forum.name}
                                                </p>
                                            </div>
                                        </div>
                                    </a>                                                                                                           
                                </c:forEach>                                
                            </div>                            
                        </div>
                    </div>
                    <div id="" class="custom-border pb-3 pr-3 pl-3">
                        <div class="bg-dark-gray row row-col-1 pt-4">
                            <h5 class="font-weight-bold text-monospace pl-3">Contribute</h5>
                        </div>                    
                        <div class="row row-col-2 pt-2 pb-2">
                            <div class="ml-2 mr-2 w-100 pt-3 px-3">
                                <a href="post?mode=create" class="btn btn-lg btn-block btn-outline-secondary font-weight-bold text-monospace rounded-0">CREATE POST</a></br>
                                <a href="forum?mode=create" class="btn btn-lg btn-block btn-outline-secondary font-weight-bold text-monospace rounded-0">CREATE COMMUNITY</a>
                            </div>                            
                        </div>
                    </div>
                </div>
                <div class="col-7 custom-border">                    
                    <div class="row mt-3">                        
                        <div class="col-3 d-flex align-items-center font-weight-bold">
                            <span class="px-2 border-right"><a href="forum?order=older">older</a></span> 
                            <span class="px-2 border-right"><a href="forum?order=newer">newer</a></span> 
                            <span class="px-2 "><a href="forum?order=most_subscriber">most subscribers</a></span>  
                        </div>
                        <div class="col">
                            <form class="form d-flex">
                                <input class="form-control mr-sm-2 rounded-0" type="search">
                                <button class="btn btn-outline-secondary my-2 my-sm-0 rounded-0 text-monospace" type="submit">search</button>
                            </form>
                        </div>
                        <div class="col-2"></div>
                    </div>
                    <ul class="list-unstyled my-4 mx-2">
                        <c:forEach var="forum" items="${forums}">                            
                            <li class="row media custom-border my-4 p-2">
                                <a class="d-flex col-12 mb-2" href="forum?f=${forum.id}">
                                    <img class="mr-3" src="${forum.imagePath}" alt="" height="70" width="70">
                                    <div class="media-body">
                                        <h5 class="mt-0 mb-1 font-weight-bold text-monospace">${forum.name}</h5>
                                        <span class="text-monospace">${fn:length(forum.description) > 500 ? fn:substring(forum.description, 0, 499).concat('...') : forum.description}</span>                                                                       
                                    </div>                                    
                                </a>                                
                                <span class="col-8"></span>
                                <a href="" class="col-1 badge badge-secondary rounded-0 mx-1 bg-black custom-border text-success">u/${forum.createdBy.name}</a>
                                <a href="forum?mode=create&action=edit&id=${forum.id}" class="col-1 badge badge-secondary rounded-0 mx-1 bg-black custom-border">edit</a>
                                <a href="forum?action=delete&id=${forum.id}" class="col-1 badge badge-secondary rounded-0 mx-1 bg-black custom-border text-danger">delete</a>
                            </li>                            
                        </c:forEach>                                                
                    </ul>                    
                </div>
                <div class="col-1"></div>
            </div>
        </jsp:body>
    </t:page>    