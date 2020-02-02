<%-- 
    Document   : post
    Created on : Jan 28, 2020, 1:32:15 AM
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
        <link rel="stylesheet" type="text/css" href="resources/css/post.css">
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
    </jsp:attribute>
    <jsp:attribute name="script">
        <script>
            $(document).ready(() => {                
                let scroll = localStorage.getItem("scrollView");
                if(scroll !== null)
                    document.getElementById(scroll).scrollIntoView();
            });
        </script>
        <script>
            function comment(parent = "", comment_id = null) {
                console.log(parent);
                console.log(comment_id);
                let input_user = $('#user_input').val();
                let parent_id = $('#currentCommentId').val();
                let comment = null;

                if (comment_id === null) {
                    comment = document.getElementsByClassName('ql-editor')[0].innerHTML;
                    localStorage.setItem("scrollView", "page-bottom");                    
                } else {
                    console.log("editor" + parent + "-" + parent_id);
                    console.log(comment);
                    comment = document.getElementById("editor" + parent + "-" + parent_id).childNodes[0].innerHTML;                    
                    localStorage.clear();
                }

                if (input_user !== '') {
                    $.ajax({
                        type: 'GET',
                        url: 'http://localhost:8080/WEB-2.01/json?user=' + input_user + '&post=${post.id}&comment=' + comment + '&parent=' + parent_id
                    });
                }
                                
                document.getElementById('body').classList.add('low-screen-brightness');
                setTimeout( () => {window.location.reload(true)}, 100);                                
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
        <script>
            function placeholder() {
                document.getElementsByClassName('ql-editor')[0].innerHTML = '<p>What are your tougths?</p>';
            }
            window.onload = placeholder();

            document.getElementsByClassName('ql-editor')[0]
                    .addEventListener("click", () => {
                        if (document.getElementsByClassName('ql-editor')[0].innerHTML === "<p>What are your tougths?</p>")
                            document.getElementsByClassName('ql-editor')[0].innerHTML = "";
                    });

            document.getElementsByClassName('ql-editor')[0]
                    .addEventListener("blur", () => {
                        if (document.getElementsByClassName('ql-editor')[0].innerHTML === "<p><br></p>")
                            document.getElementsByClassName('ql-editor')[0].innerHTML = "<p>What are your tougths?</p>";
                    });
        </script>
        <script>
            function commentEditor(comment_id) {

                if (typeof (document.getElementById("editor-" + comment_id)) === 'undefined' || document.getElementById("editor-" + comment_id) === null)
                {
                    let children = document.getElementById('comment-children-' + comment_id);

                    if (children === null) {
                        console.log("children nulo");
                        children = document.getElementById('comment-parent-' + comment_id);
                    }

                    let newItem = document.createElement("LI");
                    let commentButton = document.createElement("BUTTON");
                    let div = document.createElement("DIV")

                    newItem.innerHTML = '<div id="editor-' + comment_id + '"></div>';

                    commentButton.classList.add("btn", "btn-blue", "btn-sm", "text-monospace", "rounded-0")
                    commentButton.appendChild(document.createTextNode("comment"));
                    commentButton.setAttribute("data-toggle", "modal");
                    commentButton.setAttribute("data-target", "#exampleModalCenter");

                    commentButton.onclick = function () {
                        document.getElementById("currentCommentId").setAttribute("value", comment_id);
                        document.getElementById("comment-button").setAttribute("onclick", "comment('', '" + comment_id + "')");
                    };

                    div.classList.add("d-flex", "flex-row-reverse");
                    div.appendChild(commentButton);

                    if (children.childNodes[1].nodeName === "DIV") {
                        console.log("primeiro");
                        let newUl = document.createElement("UL");
                        newUl.classList.add("list-unstyled", "mt-3");
                        newUl.appendChild(newItem);
                        children.appendChild(newUl);
                        children.appendChild(div);

                    } else if (children.childNodes[1].nodeName === "LI" && !children.childNodes[1].hasChildNodes()) {
                        console.log("segundo");
                        let newUl = document.createElement("UL");
                        newUl.classList.add("list-unstyled", "mt-3");
                        newUl.appendChild(newItem);
                        children.childNodes[1].append(newUl);
                        children.childNodes[1].append(div);
                    } else {
                        console.log("terceiro");
                        children.insertBefore(newItem, children.childNodes[0]);
                        children.insertBefore(div, children.childNodes[1]);
                    }

                    let quill = new Quill('#editor-' + comment_id, {
                        theme: 'snow'
                    });
                } else {
                    let editor = document.getElementById("editor-" + comment_id);
                    editor.parentElement.remove();

                    let children = document.getElementById('comment-children-' + comment_id);

                    if (children === null) {
                        children = document.getElementById('comment-parent-' + comment_id);
                    }

                    if (children.childNodes[1].nodeName === "DIV") {
                        children.lastChild.remove();
                    } else if (children.childNodes[1].nodeName === "LI") {
//                        console.log(children.childNodes[1].childNodes);
                        children.childNodes[1].childNodes[3].remove();
                        children.childNodes[1].childNodes[3].remove();
                    } else {
                        children.childNodes[0].remove();
                    }
                }
            }

            function commentEditorParent(comment_id) {
                if (typeof (document.getElementById("editor-parent-wrapper-" + comment_id)) === 'undefined' || document.getElementById("editor-parent-wrapper-" + comment_id) === null)
                {
                    let parent = document.getElementById('comment-parent-' + comment_id);
                    let children = parent.querySelectorAll("li");
                    let editor_wrapper = document.createElement("DIV");
                    let editor = document.createElement("DIV");
                    let comment_button = document.createElement("BUTTON");
                    let comment_button_wrapper = document.createElement("DIV");

                    comment_button.classList.add("btn", "btn-blue", "btn-sm", "text-monospace", "rounded-0")
                    comment_button.appendChild(document.createTextNode("comment"));
                    comment_button.setAttribute("data-toggle", "modal");
                    comment_button.setAttribute("data-target", "#exampleModalCenter");

                    comment_button.onclick = function () {
                        document.getElementById("currentCommentId").setAttribute("value", comment_id);
                        document.getElementById("comment-button").setAttribute("onclick", "comment('-parent', '" + comment_id + "')");
                    };

                    comment_button_wrapper.classList.add("d-flex", "flex-row-reverse");
                    comment_button_wrapper.appendChild(comment_button);

                    editor.setAttribute("id", "editor-parent-" + comment_id);
                    editor_wrapper.setAttribute("id", "editor-parent-wrapper-" + comment_id);
                    editor_wrapper.appendChild(editor);
                    editor_wrapper.appendChild(comment_button_wrapper);

                    if (children.length > 0)
                    {
                        console.log(children[0]);
//                    console.log(comments_tree);

                        let comments_tree = children[0].querySelectorAll("ul");
                        console.log(comments_tree);
                        if (comments_tree.length > 0)
                        {
                            comments_tree[0].insertBefore(editor_wrapper, comments_tree[0].childNodes[0]);

                            let quill = new Quill('#editor-parent-' + comment_id, {
                                theme: 'snow'
                            });
                        } else
                        {
                            let ul = document.createElement("UL");
                            let li = document.createElement("LI");

                            li.appendChild(editor_wrapper);
                            ul.appendChild(li);

                            ul.classList.add("list-unstyled", "mt-3");

                            children[0].appendChild(ul);

                            let quill = new Quill('#editor-parent-' + comment_id, {
                                theme: 'snow'
                            });
                        }
                    }
                } else
                {
                    document.getElementById("editor-parent-wrapper-" + comment_id).remove();
                }
            }
        </script>
        <script>
            function eraseComment(comment_id) {
                $.ajax({
                    type: 'GET',
                    url: "http://localhost:8080/WEB-2.01/json?comment=" + comment_id + "&erase=1"
                });
                document.getElementById('body').classList.add('low-screen-brightness');
                setTimeout( () => {window.location.reload(true)}, 100);
            }
        </script>
    </jsp:attribute>
    <jsp:body>        
        <div class="container-fluid">
            <div class="row mt-3">                
                <div class="col-1"></div>
                <div class="col-3">
                    <div id="" class="custom-border pr-3 pl-3 mb-3">
                        <div class="bg-dark-gray row row-col-1 pt-4">
                            <p></p>                            
                        </div>                        
                        <div class="row row-col-2 pt-2">
                            <div class="pl-4 pr-4 pt-3 w-100">
                                <img class="" src="${post.forum.imagePath}" height="50" width="50">
                                <span class="ml-2 forum-name text-monospace font-weight-bold">${post.forum.name}</span>
                            </div>
                            <div class="pl-4 pr-4 pt-3 w-100">
                                <span class="text-monospace">${post.forum.description}</span>
                            </div>
                            <div class="ml-2 mr-2 w-100 pt-3 px-3">
                                <a href="post?mode=create" class="btn btn-lg btn-block btn-outline-secondary font-weight-bold text-monospace rounded-0">JOIN</a></br>                                
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
                    <div class="pt-4">
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
                            <h5 class="text-monospace">${post.title}</h5>
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
                        <div class="col-12 mt-4">
                            <div id="editor">                                
                            </div>
                            <div class="d-flex flex-row-reverse">
                                <button class="btn btn-blue text-monospace rounded-0 mt-2" data-toggle="modal" data-target="#exampleModalCenter">
                                    comment
                                </button>                                
                            </div>                            
                        </div>                                                    

                        <div class="modal" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content rounded-0 border bg-black">
                                    <div class="modal-header">
                                        <h5 class="modal-title text-monospace" id="exampleModalLongTitle">
                                            Select an account to comment
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
                                        <button type="button" id="comment-button" class="btn btn-blue rounded-0 text-monospace" data-dismiss="modal" onclick="comment()">comment</button>
                                    </div>
                                </div>                                
                            </div>
                        </div>

                        <input type="hidden" id="currentCommentId">

                        <div class="col-12 mt-3">
                            <c:forEach var="comment" items="${comments}">
                                <ul class="list-unstyled" id="comment-parent-${comment.id}">
                                    <li class="border-left">
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
                                                    <small onclick="commentEditorParent(${comment.id})" 
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
                                                <jsp:include page="/views/comment/comment.jsp"/>                                        
                                            </ul>                                                            
                                        </c:if>
                                    </li>                                        
                                </ul>
                            </c:forEach>
                        </div>
                    </div>
                    <div id="page-bottom"></div>
                </div>
                <div class="col-1"></div>
            </div>            

            <!-- Initialize Quill editor -->
            <script>
                var options = {
                    theme: 'snow'
                };

                var quill = new Quill('#editor', options);
            </script>
        </jsp:body>
    </t:page>    
