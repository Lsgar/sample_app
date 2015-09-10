# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
 LIMIT = 140
 count = $('span#micropost_count')
 count.text("あと" + LIMIT + "文字")

 countChars = (textarea)->
   remaining = LIMIT - textarea.val().length
   count.text("あと" + remaining + "文字")

 $('#micropost_content').keyup ->
   countChars($(this))

 # (function() {
 #   var LIMIT = 140;
 #   var counter = document.getElementById('micropost_count');
 #   var content = document.getElementById('micropost_content');
 #
 #   counter.innerHTML="あと" + LIMIT + "文字";
 #
 #   function countChars() {
 #     remaining = LIMIT - content.value.length;
 #     counter.innerHTML = "あと" + remaining + "文字";
 #   }
 #
 #   content.addEventListener('keyup', countChars, false);
 # })();
