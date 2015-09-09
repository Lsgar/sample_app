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

# <%= javascript_tag do %>
#   var LIMIT = 140;
#   var p = document.getElementById('micropost_count');
#
#   function countChars() {
#     remaining = LIMIT - document.getElementById('micropost_content').value.length;
#     p.text = remaining;
#   }
#
#   p.addEventListener('onkeyup', countChars, false);
# <% end %>
