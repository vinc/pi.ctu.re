$(document).on('turbolinks:load', function() {
  $('#gallery').justifiedGallery({
    captions: false,
    rowHeight: 200,
    maxRowHeight: 250,
    lastRow: 'nojustify',
    margins: 10,
    border: 0
  });
});
