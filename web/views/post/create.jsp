<%-- 
    Document   : create
    Created on : Jan 22, 2020, 12:13:29 AM
    Author     : zilas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                $('#the-form input[type=radio]').on('change', () => {
                    let selected = $('input[name=post_type]:checked').val();
                    if (selected == 1) {
                        $('#post_text_form').addClass('d-none');
                        $('#post_image_form').removeClass('d-none');
                    } else {
                        $('#post_text_form').removeClass('d-none');
                        $('#post_image_form').addClass('d-none');
                    }
                });
            });
        </script>
        <script>
            $(document).ready(() => {
                let selected = $('input[name=post_type]:checked').val();
                if (selected == 1) {                    
                    $('#post_text_form').addClass('d-none');
                    $('#post_image_form').removeClass('d-none');
                } else {                    
                    $('#post_text_form').removeClass('d-none');
                    $('#post_image_form').addClass('d-none');
                }
            });
        </script>
    </jsp:attribute>
    <jsp:body>        
        <div class="container-fluid">
            <div class="row mt-3" id="teste">
                <div class="col-2">
                    <div id="profile-container" class="custom-border pb-3 pr-3 pl-3">
                        <div class="bg-dark-gray row row-col-1 pt-4">
                            <div class="col-12">
                                <img class="img-thumbnail" src="${pageContext.request.contextPath}/resources/images/avatar_default_01_545452.png" alt="" height="80" width="80">
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
                                <img class="" src="${pageContext.request.contextPath}/resources/images/noun_Birthday_2294371.png" height="15" width="15">
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
                        <h3 class="text-monospace border-bottom">Create - Post</h3>                      

                        <form action="post?mode=create" method="POST" enctype="multipart/form-data" class="form-row justify-content-center mt-5" id="the-form">

                            <input type="hidden" name="form_flag" value="not_null">       
                            
                            <input type="hidden" name="post_id" value="${post != null ? post.id : 0}">
                            <input type="hidden" name="post_body_id" value="${post != null ? post.body.id : 0}">

                            <div class="col-8 btn-group btn-group-toggle btn-block" data-toggle="buttons">
                                <label class="btn btn-outline-secondary text-monospace ${post == null ? "active" : post.body.type == 0 ? "active" : ""} rounded-0">
                                    <input type="radio" name="post_type" id="post_text_button" value="0" autocomplete="off" ${post.body.type == 0 ? "checked" : "" }> Post
                                </label>
                                <label class="btn btn-outline-secondary text-monospace ${post == null ? "" : post.body.type == 1 ? "active" : ""} rounded-0">
                                    <input type="radio" name="post_type" id="post_image_button" value="1" autocomplete="off" ${post.body.type == 1 ? "checked" : "" }> Image
                                </label>                            
                            </div>

                            <div class="col-8 mt-3" id="post_user">
                                <div class="form-group">
                                    <h5 class="form-text text-monospace">User</h5>
                                    <input class="form-control rounded-0" type="text" name="post_creator" value="${post != null ? post.forum.createdBy.name : ""}">
                                </div>
                            </div>

                            <div class="col-8 " id="post_user">
                                <div class="form-group">
                                    <h5 class="form-text text-monospace">Forum</h5>
                                    <input class="form-control rounded-0" type="text" name="post_forum" value="${post != null ? post.forum.name : ""}">
                                </div>
                            </div>
                            <div class="col-8">
                                <div class="form-group ">
                                    <h5 class="form-text text-monospace">Title</h5>
                                    <input class="form-control rounded-0" type="text" name="post_title" value="${post != null ? post.title : ""}">
                                </div>                                                                
                            </div>

                            <div class="col-8" id="post_text_form">                                
                                <div class="form-group">
                                    <h5 class="form-text text-monospace">Description</h5>
                                    <textarea class="form-control rounded-0 overflow-hidden" id="forum_description" type="text" name="post_content" rows="15">
                                        ${post.body.content != null && post.body.type == 0 ? post.body.content : ""}
                                    </textarea>                                    
                                </div>
                            </div>                              

                            <div class="d-none col-8 mt-3" id="post_image_form">                                
                                <div class="form-group">
                                    <h5 class="form-text text-monospace">Upload an image</h5>
                                    <div class="custom-file">
                                        <input type="file" accept="image/png, image/jpeg, image/jpg" name="post_image"
                                               class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
                                        <label class="custom-file-label bg-black custom-border text-monospace rounded-0" for="inputGroupFile01">Choose a file</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 text-center mt-3">
                                <button type="submit" class="btn btn-outline-secondary btn-lg rounded-0 font-weight-bold text-monospace mt-1" href="">
                                    CREATE
                                </button>    
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div> 
    </jsp:body>                
</t:page>
