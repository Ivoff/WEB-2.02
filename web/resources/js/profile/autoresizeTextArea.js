/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(() => {
    $('#forum_description').on('input', function () {
        this.style.height = 'auto';

        this.style.height = (this.scrollHeight) + 'px';
    });
});