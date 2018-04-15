// Timeline notifications
$(document).on('turbolinks:load', function() {
  App.notifications = {
    pictures: {}
  };

  if ($('body').hasClass('timeline-index')) {
    App.cable.subscriptions.create({ channel: 'TimelineChannel' }, {
      received: function(data) {
        if ('picture' in data) {
          var token = data.picture;

          App.notifications.pictures[token] = "created";

          var count = Object.keys(App.notifications.pictures).length;
          var subject = count + ' new picture' + (count === 1 ? '' : 's');
          var refresh_link = '<a href="/" class="alert-link">Refresh</a>';
          var notification = '<div class="alert alert-info" role="alert">' + refresh_link + ' to see ' + subject + '</div>';

          $('body.timeline-index #notification').html(notification);

          document.title = '(' + count + ') Picture';
        }
      }
    });
  }
});
