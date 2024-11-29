import { Application } from "@hotwired/stimulus"

const application = Application.start()

application.debug = false
window.Stimulus   = application

export { application }
// Disable Turbolinks (temporary test)
document.addEventListener("turbolinks:load", function () {
  // Your code here
});

document.addEventListener("turbolinks:load", function () {
    $(document).on('click', '.like-button', function (e) {
      e.preventDefault();
      var $button = $(this);
      var postId = $button.data('post-id');
      var liked = $button.data('liked');
  
      $.ajax({
        url: '/posts/' + postId + '/like',
        type: 'POST',
        success: function () {
          // เปลี่ยนข้อความในปุ่ม Like/Unlike
          if (liked) {
            $button.text('Like');
            $button.data('liked', false);
          } else {
            $button.text('Unlike');
            $button.data('liked', true);
          }
        },
        error: function () {
          alert('An error occurred');
        }
      });
    });
  });
  

  
  

