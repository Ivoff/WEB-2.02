/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(() => {     
    let profileContainerHeight = $('#profile-container').height();
    let headerHeight = $('#header').height();
    let remainingHeight = $(window.innerHeight).height() - (profileContainerHeight + headerHeight);    
    $('#trophies').height(remainingHeight);
});