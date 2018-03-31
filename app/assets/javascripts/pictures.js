Dropzone.autoDiscover = false;

$(document).on('turbolinks:load', function() {
  var width = 300;
  $('form.custom-dropzone').dropzone({
    acceptedFiles: 'image/*',
    parallelUploads: 1,
    paramName: 'picture[image]',
    thumbnailWidth: width,
    thumbnailHeight: width,
    init: function() {
      this.on('success', function(file, res) {
        var image = res.image_filename;
        var url = res.image.url.replace(image, width + 'x' + width + '!/' + image);

        this.emit('thumbnail', file, url);
        this.createThumbnailFromUrl(file, url);
      });
    },
    uploadprogress: function(file, progress, bytesSent) {
      $(file.previewElement).
        find('.dz-progress .dz-upload').
        css('height', (100 - progress) + '%');
    }
  });

  $('#gallery.justified-gallery').justifiedGallery({
    waitThumbnailsLoad: false,
    captions: false,
    rowHeight: 200,
    maxRowHeight: 250,
    lastRow: 'nojustify',
    margins: 10,
    border: 0
  });

  $("input:file").change(function() {
    var f = this.files;
    var n = this.files.length;
    var msg = n > 1 ? n + " files selected" : f[0].name;

    if (this.id) {
      $(".custom-file-label[for=" + this.id + "]").text(msg);
    }
  });


  var busy = false;

  $(document).on('scroll', function() {
    var doc = $(document);
    var win = $(window);
    var elem = $('#gallery');
    var next = $('.next-page a.infinite-scrolling');

    if (elem.length && next.length) {
      if (busy) {
        return;
      } else {
        busy = true;
      }

      var busyDuration = 100;

      if (doc.height() - doc.scrollTop() < 2 * win.height()) {
        busyDuration = 1000;
        next.removeClass('infinite-scrolling');
        next.click();
        //console.log('loading ' + next.attr('href'));
        //window.history.replaceState('', '', next.attr('href'));
      }

      setTimeout(function() {
        busy = false;
      }, busyDuration);
    }
  });
});
