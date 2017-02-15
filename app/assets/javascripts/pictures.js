$(document).on('turbolinks:load', function() {
  $('#gallery').justifiedGallery({
    waitThumbnailsLoad: false,
    captions: false,
    rowHeight: 200,
    maxRowHeight: 250,
    lastRow: 'nojustify',
    margins: 10,
    border: 0
  });

  $('.custom-file-input').on('change', function() {
    var content = $('.custom-file-input').val();

    $('.custom-file-control').attr('data-content', content);
  });
});
