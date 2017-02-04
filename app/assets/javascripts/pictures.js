$(document).on('turbolinks:load', function() {
  $('#gallery.loading')
    .removeClass('loading')
    .justifiedGallery({
      captions: false,
      rowHeight: 200,
      maxRowHeight: 250,
      lastRow: 'nojustify',
      margins: 10,
      border: 0
    });
});
