<%-- 
    Document   : forumCreate
    Created on : Dec 30, 2019, 12:24:40 PM
    Author     : zilas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entities.User"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 

<!DOCTYPE html>
<t:page currentPage="none">
    <jsp:attribute name="header">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/forum.css">
    </jsp:attribute>
    <jsp:attribute name="script">
        <script src="${pageContext.request.contextPath}/resources/js/profile/trophiesHeight.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/profile/displayFileName.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/profile/autoresizeTextArea.js"></script>
        <script>
            $(document).ready(() => {
                $('#current_forum_icon').mouseover(() => {
                    $('#current_icon_text').html('Edit?');
                    $(this).click(() => {
                        $('#current_icon_div').addClass('d-none');
                        $('#forum_file_input').removeClass('d-none');
                        $('#the-form').removeClass('align-items-end');
                    });
                }).mouseleave(() => {
                    $('#current_icon_text').html('Current icon');
                });
            });
        </script>
        <script>
            $(document).ready(() => {
                let last_state;
                $('#forum_owner').blur(() => {
                    let input_user = $('#forum_owner').val();
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
                                }else{
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
            <div class="row mt-3" id="teste">
                <div class="col-2">
                    <div id="" class="custom-border pb-3 pr-3 pl-3">
                        <div class="profile-container" id="profile-container">
                            <div class="bg-dark-gray row row-col-1 pt-4">
                                <div class="col-12">
                                    <img class="img-thumbnail" src="${pageContext.request.contextPath}/resources/images/avatar_default_01_545452.png" alt="" height="80" width="80">
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
                                    <img class="" src="${pageContext.request.contextPath}/resources/images/noun_Birthday_2294371.png" height="15" width="15">
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
                    <div id="trophies" class="custom-border pb-3 pr-3 pl-3 mt-4">
                        <h6 class="text-monospace font-weight-bold pt-3">Rules</h6>
                        <div class="overflow-auto scrollabe-row pr-2">
                            <ul>
                                <li>amet consectetur adipiscing elit duis tristique sollicitudin nibh sit amet commodo nulla facilisi nullam vehicula ipsum a arcu cursus vitae</li>
                                <li>amet consectetur adipiscing elit duis tristique sollicitudin nibh sit amet commodo nulla facilisi nullam vehicula ipsum a arcu cursus vitae</li>
                                <li>amet consectetur adipiscing elit duis tristique sollicitudin nibh sit amet commodo nulla facilisi nullam vehicula ipsum a arcu cursus vitae</li>
                                <li>amet consectetur adipiscing elit duis tristique sollicitudin nibh sit amet commodo nulla facilisi nullam vehicula ipsum a arcu cursus vitae</li>
                            </ul>
                        </div>
                    </div>
                </div>                
                <div class="custom-border col" id="form-container">
                    <div class="p-3">
                        <h3 class="text-monospace border-bottom">Create - Forum</h3>
                        <form action="forum?mode=create" method="POST" 
                              enctype="multipart/form-data" class="form-row justify-content-center d-flex ${edit != null ? "align-items-end" : "" } pt-3" id="the-form">

                            <input type="hidden" name="form_flag" value="not_null">

                            <input type="hidden" name="forum_id" value="${current_forum != null ? current_forum.id : "0"}">

                            <div class="col pr-2">
                                <div class="form-group">
                                    <h5 class="form-text text-monospace">Owner</h5>
                                    <input class="form-control rounded-0" type="text" id="forum_owner" name="forum_owner" value="${current_forum != null ? current_forum.createdBy.name : ""}">
                                </div>
                            </div>

                            <div class="col pr-2">
                                <div class="form-group">
                                    <h5 class="form-text text-monospace">Name</h5>
                                    <input class="form-control rounded-0" type="text" name="forum_name" value="${current_forum != null ? current_forum.name : ""}">
                                </div>                                                                                                                                
                            </div>                      

                            <div class="col-2 pl-2 ${edit == null ? "d-none" : "" }" id="current_icon_div">
                                <div class="form-group d-flex flex-column">           
                                    <h5 class="align-self-center form-text text-monospace" id="current_icon_text">Current icon</h5>
                                    <img class="align-self-center custom-border border p-1 edit-forum-icon" id="current_forum_icon" src="${current_forum != null ? current_forum.imagePath : ""}" height="150" width="150">                                    
                                </div>                                                                
                            </div>                            

                            <div class="col pl-2 ${edit != null ? "d-none" : "" }" id="forum_file_input">
                                <div class="form-group">           
                                    <h5 class="form-text text-monospace">Upload an image</h5>
                                    <div class="custom-file">
                                        <input type="file" accept="image/png, image/jpeg, image/jpg" name="forum_icon"
                                               class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
                                        <label class="custom-file-label bg-black custom-border text-monospace rounded-0" for="inputGroupFile01">Choose a file</label>
                                    </div>
                                    <small class="form-text text-monospace text-white">This will be your forum icon. If no image is submitted it'll be setted to default icon</small>
                                </div>                                                                
                            </div>
                            <div class='col-12'>
                                <div class="form-group">
                                    <h5 class="form-text text-monospace">Description</h5>
                                    <textarea class="form-control rounded-0 overflow-hidden" id="forum_description" type="text" name="forum_description" rows="6"
                                              placeholder="Here you could put some rules and the forum objective">${current_forum != null ? current_forum.description : ""}</textarea>
                                    <small class="form-text text-monospace text-white">This can be empty, it's optional.</small>
                                </div>
                            </div>                            
                            <button type="submit" class="btn btn-outline-secondary btn-lg rounded-0 font-weight-bold text-monospace mt-1" href="">
                                ${edit != null ? "EDIT" : "CREATE"}
                            </button>                            
                        </form>
                    </div>
                </div>
            </div>
        </div> 
    </jsp:body>                
</t:page>