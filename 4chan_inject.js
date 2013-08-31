// Generated by IcedCoffeeScript 1.6.3-f


chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
  var info, matcher, mobileMatch, opMatch, post, postclass, quoteLink, _i, _len, _ref, _results;
  if (request.action !== 'highlight_posts') {
    return;
  }
  matcher = new RegExp(request.matcher);
  mobileMatch = /mobile/;
  opMatch = /post op/;
  _ref = $('a[title="Quote this post"]');
  _results = [];
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    quoteLink = _ref[_i];
    info = quoteLink.parentElement.parentElement;
    if (mobileMatch.test(info.getAttribute('class'))) {
      continue;
    }
    post = info.parentElement;
    if (opMatch.test(post.getAttribute('class'))) {
      continue;
    }
    postclass = "post reply" + (matcher.test(quoteLink.innerHTML) ? ' highlight' : '');
    _results.push(post.setAttribute('class', postclass));
  }
  return _results;
});
