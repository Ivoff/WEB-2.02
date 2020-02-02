<%-- 
    Document   : post
    Created on : Jan 21, 2020, 11:51:53 PM
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

<t:page currentPage="post/index">
    <jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="resources/css/forum.css">
    </jsp:attribute>
    <jsp:attribute name="script">
        <script>
            
            function setPostId(post_id, vote){
                $('#post_id').val(post_id);
                $('#vote').val(vote);
            }
            
            //http://localhost:8080/WEB-2.01/json?post=86&vote=1&user=138
            function vote() {
                let user = $('#user_input').val();
                let post = $('#post_id').val();
                let vote = $('#vote').val();
                console.log('http://localhost:8080/WEB-2.01/json?post='+post+'&vote='+vote+'&user='+user);
                $.ajax({
                    type: 'GET',
                    url: 'http://localhost:8080/WEB-2.01/json?post='+post+'&vote='+vote+'&user='+user
                });
//                let currentValue = $('#' + post_id).html();
//                $('#' + post_id).html(1 + Number(currentValue));
            }           
        </script>
        <script>
            $(document).ready(() => {
                let last_state;
                $('#user_input').blur(() => {
                    let input_user = $('#user_input').val();
                    if (input_user !== '' && last_state !== input_user) {
                        last_state = input_user;
                        $.ajax({
                            type: 'GET',
                            url: 'http://localhost:8080/WEB-2.01/json?user=' + input_user,
                            success: (response) => {
                                console.log(response);
                                if (response !== null) {
                                    if ($('#profile-container').hasClass('profile-container')) {
                                        $('#profile-container').removeClass('profile-container');
                                    }
                                    $('#user_name').html('u/' + response.name);
                                    $('#user_birthday').html(response.birthday.replace('12:00:00 AM', ''));
                                    $('#user_forums').html(response.relations.forums);
                                    $('#user_posts').html(response.relations.posts);
                                } else {
                                    if (!$('#profile-container').hasClass('profile-container')) {
                                        $('#profile-container').addClass('profile-container');
                                    }
                                }
                            }
                        });
                    }
                });
            });
        </script>
    </jsp:attribute>
    <jsp:body>        
        <div class="container-fluid">
            <div class="row mt-3">
                <div class="col-1"></div>
                <div class="col-3">                    
                    <div id="" class="custom-border pb-3 pr-3 pl-3 mb-3">
                        <div class="bg-dark-gray row row-col-1 pt-4">
                            <h5 class="font-weight-bold text-monospace pl-3">Posts - Recently created</h5>
                        </div>                    
                        <div class="row row-col-2 pt-2 pb-2">
                            <div class="ml-2 mr-2 w-100">
                                <c:forEach var="post" items="${posts_recently}">                                    

                                    <div class="overflow-auto row row-col-2 mt-3 ml-2 mr-2 border-bottom">                                            

                                        <div class="col-3 my-2 d-flex flex-column">
                                            <img src="${post.forum.imagePath}" alt="" height="55" width="55">                                                                                                                                                
                                        </div>                                            
                                        <div class="col-9">                                                                                                
                                            <div class="d-flex flex-row-reverse">
                                                <a href="" class="col-4 badge badge-secondary rounded-0 bg-black custom-border text-success text-monospace">u/${post.createdBy.name}</a>
                                                <a href="" class="col-4 badge badge-secondary rounded-0 bg-black custom-border text-warning text-monospace">f/${post.forum.name}</a>
                                            </div>
                                            <a href="post?p=${post.id}" class="font-weight-bold text-monospace mt-3 mb-2 d-block">      
                                                ${post.title}
                                            </a>                                                
                                        </div>                                            
                                    </div>

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
                <div class="col-7 custom-border ">                    
                    <div class="row py-3 ">                        
                        <div class="col-3 d-flex align-items-center font-weight-bold">
                            <span class="px-2 border-right"><a href="post?order=older">older</a></span> 
                            <span class="px-2 border-right"><a href="post?order=newer">newer</a></span> 
                            <span class="px-2 "><a href="post?order=most_subscriber">most subscribers</a></span>  
                        </div>
                        <div class="col">
                            <form class="form d-flex">
                                <input class="form-control mr-sm-2 rounded-0" type="search">
                                <button class="btn btn-outline-secondary my-2 my-sm-0 rounded-0 text-monospace" type="submit">search</button>
                            </form>
                        </div>
                        <div class="col-2"></div>
                    </div>
                    <div>
                        <input type="hidden" id="post_id">
                        <input type="hidden" id="vote">
                        <div class="modal" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content rounded-0 border bg-black">
                                    <div class="modal-header">
                                        <h5 class="modal-title text-monospace" id="exampleModalLongTitle">
                                            Select an user account to vote
                                        </h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <h5 class="form-text text-monospace">User name</h5>
                                        <div class="form-group d-flex">                                                                                                                            
                                            <input class="form-control rounded-0" type="text" id="user_input">                                                            
                                            <button class="btn btn-outline-secondary text-monospace rounded-0">find</button>
                                        </div>
                                        <div class="profile-container" id="profile-container">
                                            <div class="bg-dark-gray row row-col-1 pt-4">
                                                <div class="col-12">
                                                    <img class="img-thumbnail" src="resources/images/avatar_default_01_545452.png" alt="" height="80" width="80">
                                                </div>                        
                                                <h7 class="col mt-1 font-weight-bold text-monospace text-success" id="user_name"></h7>
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
                                                    <small id="user_birthday"></small>
                                                </div>
                                                <div class="col-6">
                                                    <h6 class="font-weight-bold text-monospace">Posts</h6>
                                                </div>
                                                <div class="col-6">
                                                    <h6 class="font-weight-bold text-monospace">Forums</h6>                            
                                                </div>
                                                <div class="col-6" id="user_posts">
                                                    todo
                                                </div>
                                                <div class="col-6 mb-4" id="user_forums">
                                                    todo
                                                </div>
                                                <div class="col-12">
                                                    <h6 class="font-weight-bold text-monospace">Account Time</h6>
                                                </div>
                                                <div class="col-12 mb-2">
                                                    todo
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">                                                        
                                        <button type="button" id="" class="btn btn-outline-secondary rounded-0 text-monospace" data-dismiss="modal" onclick="vote(${post.id})">vote</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <c:forEach var="post" items="${posts}">
                            <div class="row my-3"> 
                                <div class="col-1"></div>
                                <div class="col-10 custom-border py-2">
                                    <div class="col-12">                                        
                                        <span class="col-4 badge badge-secondary rounded-0 bg-black text-monospace d-flex align-items-center">                                                                                    
                                            <img class="" src="${post.forum.imagePath}" height="30" width="30">                                    
                                            <a class="mx-2" href="">f/${post.forum.name}</a>
                                            <span class="text">- Posted by</span> 
                                            <a class="mx-2" href="">u/${post.createdBy.name}</a>                                        
                                            <span class="text-success mr-2">${post.duration} </span> 
                                            <span class="text">ago</span>
                                        </span>
                                    </div>
                                    <div class="col-12 mt-2">
                                        <a href="post?p=${post.id}"><h5 class="text-monospace">${post.title}</h5></a>
                                    </div>
                                    <div class="col d-flex justify-content-center">
                                        <c:if test="${post.body.type == 1}">
                                            <img class="post-image" src="${post.body.content}">
                                        </c:if>
                                        <c:if test="${post.body.type == 0}">
                                            <span class="text-monospace my-2">
                                                ${post.body.content}
                                            </span>
                                        </c:if>
                                    </div>
                                    <div class="col-12 d-flex align-items-center">                                                                                
                                        <span data-toggle="modal" data-target="#exampleModalCenter" onclick="setPostId(${post.id}, 1)" class="vote" id="upvote">▲ </span>
                                        <span class="vote" id="downvote" data-toggle="modal" data-target="#exampleModalCenter" onclick="setPostId(${post.id}, '-1')">▼ </span>                                                   
                                        <span class="vote mx-3"> | </span>                     
                                        <span class="pt-1" id="${post.id}">${post.votes}</span>
                                        <div class="col-1"></div>                                        
                                        <a class="pt-2 text-monospace" href="">comments</a>
                                        <div class="col pt-2 d-flex flex-row-reverse">
                                            <a href="post?mode=create&action=edit&id=${post.id}" class="col-2 badge badge-secondary rounded-0 mx-1 bg-black custom-border">edit</a>
                                            <a href="post?action=delete&id=${post.id}" class="col-2 badge badge-secondary rounded-0 mx-1 bg-black custom-border text-danger">delete</a>
                                        </div>
                                    </div>
                                </div>                                
                                <div class="col-1"></div>
                            </div>
                        </c:forEach>                                                
                    </div>                    
                </div>
                <div class="col-1"></div>
            </div>
        </jsp:body>
    </t:page>    