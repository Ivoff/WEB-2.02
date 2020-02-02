<%-- 
    Document   : comment
    Created on : Jan 30, 2020, 1:43:38 AM
    Author     : zilas
--%>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entities.Comment" %>
<!DOCTYPE html>

<c:forEach var="comment" items="${comment.children}">
    <li class="border-left my-4" id="comment-children-${fn:length(comment.children) gt 0 ? "" : comment.id}">
        <div class="col-12">
            <small class="bg-black text-monospace text-white font-weight-bold d-flex align-items-end mb-2">
                <c:if test="${comment.user != null}">
                    <a class="" href="">u/${comment.user.name}</a>
                    <span class="text-success mx-2">${comment.duration} </span> 
                    <span class="text">ago</span>
                </c:if>
                <c:if test="${comment.user == null}">
                    <span class="deleted-comment text-monospace">deleted comment</span>
                </c:if>
            </small>
            <span class="text-monospace" id="comment-${comment.id}">
                ${comment.body}
            </span>
            <c:if test="${comment.user != null}">
                <div class="d-flex">                                                
                    <small onclick="commentEditor(${comment.id})" 
                           class="border px-1 text-monospace font-weight-bold text-white reply-button">
                        reply
                    </small>                                                
                    <small onclick="" 
                           class="border mx-2 px-1 text-monospace font-weight-bold text-white comment-edit-button">
                        edit
                    </small>
                    <small onclick="eraseComment(${comment.id})" 
                           class="border px-1 text-monospace font-weight-bold text-white comment-delete-button">
                        delete
                    </small>
                </div>
            </c:if>
        </div>
        <c:if test="${fn:length(comment.children) gt 0}">        
            <ul class="list-unstyled mt-3" id="comment-children-${comment.id}">
                <c:set var="comment" value="${comment}" scope="request"/>
                <jsp:include page="comment.jsp"/>
            </ul>        
        </c:if>
    </li>            
</c:forEach>