<%-- 
    Document   : profile
    Created on : Dec 28, 2019, 12:58:06 PM
    Author     : zilas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entities.User"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 

<!DOCTYPE html>
<t:page currentPage="none">
    <jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="resources/css/profile.css">
    </jsp:attribute>
    <jsp:attribute name="script">
        <script src="resources/js/profile/trophiesHeight.js"></script>
    </jsp:attribute>
    <jsp:body>        
        <div class="container-fluid">
            <div class="row mt-3">
                <div class="col-2">
                    <div id="profile-container" class="custom-border pb-3 pr-3 pl-3">
                        <div class="bg-dark-gray row row-col-1 pt-4">
                            <div class="col-12">
                                <img class="img-thumbnail" src="resources/images/avatar_default_01_545452.png" alt="" height="80" width="80">
                            </div>                        
                            <h7 class="col mt-1 font-weight-bold text-monospace text-success">u/${user.name}</h7>
                        </div>                    
                        <div class="row row-col-2 pt-2 pb-2">
                            <div class="col-6">
                                <h6 class="font-weight-bold text-monospace">Likes Total</h6>
                            </div>
                            <div class="col-6">
                                <h6 class="font-weight-bold text-monospace"> Birthday</h6>                            
                            </div>
                            <div class="col-6">
                                todo                                
                            </div>                            
                            <div class="col-6 mb-4">
                                <img class="" src="resources/images/noun_Birthday_2294371.png" height="15" width="15">
                                <small><fmt:formatDate pattern="dd-MM-yyyy" value="${user.birthday}"/></small>
                            </div>
                            <div class="col-6">
                                <h6 class="font-weight-bold text-monospace">Posts</h6>
                            </div>
                            <div class="col-6">
                                <h6 class="font-weight-bold text-monospace">Forums</h6>                            
                            </div>
                            <div class="col-6">
                                todo
                            </div>
                            <div class="col-6 mb-4">
                                todo
                            </div>
                            <div class="col-12">
                                <h6 class="font-weight-bold text-monospace">Account Time</h6>
                            </div>
                            <div class="col-12 mb-2">
                                todo
                            </div>
                            <div class="col-12">
                                <a class="btn btn-outline-secondary btn-block font-weight-bold text-monospace mt-3 mb-2" href="">
                                    NEW POST
                                </a>
                            </div>
                            <div class="col-12">
                                <a class="btn btn-outline-secondary btn-block font-weight-bold text-monospace mt-1" href="forum/create">NEW FORUM</a>
                            </div>                
                        </div>
                    </div>                            
                    <div id="trophies" class="custom-border pb-3 pr-3 pl-3 mt-4">
                        <h6 class="text-monospace font-weight-bold pt-3">Trophies</h6>
                        <div class="overflow-auto row row-col-2 scrollabe-row">
                            <div class="col-3">
                                <img src="resources/images/generic-logo-ECC6ED04F3-seeklogo.com.png" height="55" width="55">
                            </div>
                            <div class="col-9">
                                <small class="text-monospace font-weight-light">
                                    askdalskj jlkasjdlkj laskjdlakjs alskdjaksld lasjlkj lajsldjlj lkasjdlkj lajsdlj laksjdlakj
                                </small>
                            </div>                           
                        </div>
                    </div>
                </div>                
                <div class="custom-border col">

                </div>
            </div>
        </div> 
    </jsp:body>                
</t:page>
