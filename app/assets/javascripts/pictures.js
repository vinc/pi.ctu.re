$(document).on('turbolinks:load', function() {
  $('#gallery.loading')
    .removeClass('loading')
    .justifiedGallery({
      rowHeight: 160,
      lastRow: 'hide',
      margins: 10,
      border: 0
    });
});
