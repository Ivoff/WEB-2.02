/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {                     
    let remainingHeight = $('body').height() - ($('#profile-container').height() + $('#header').height());              
    $('#trophies').height(remainingHeight);
});