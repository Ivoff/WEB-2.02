<%-- 
    Document   : nevbar
    Created on : Dec 27, 2019, 8:19:04 PM
    Author     : zilas
--%>

<%@tag description="page structure" pageEncoding="UTF-8"%>

<%@attribute name="head" fragment="true" %>
<%@attribute name="header" fragment="true" %>
<%@attribute name="footer" fragment="true" %>
<%@attribute name="script" fragment="true" %>

<%@attribute name="currentPage" required="true" rtexprvalue="true" %>

<%@taglib prefix="t" tagdir="/WEB-INF/tags/"%>

<html>
    <head>
        <t:header></t:header>
        <jsp:invoke fragment="head"/>
    </head>
    <body>
        <div id="header">
            <t:nav  currentPage="${currentPage}"></t:nav>            
            <jsp:invoke fragment="header"/>        
        </div>
        
        <div id="body">
            <jsp:doBody/>
        </div>
        
        <div id="footer">
            <jsp:invoke fragment="footer"/>
        </div>
        
        <div id="script">     
            <jsp:invoke fragment="script"/>
        </div>
    </body>
</html>