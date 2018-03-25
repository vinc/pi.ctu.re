// Email address demunging
$(document).on('turbolinks:load', function() {
  $('a[href^="mailto:"]').each(function() {
    var link = $(this);
    var href = $(this).attr('href').replace('(@_@)', '@');

    link.attr('href', href);
    link.text(href.replace('mailto:', ''));
  });
});
