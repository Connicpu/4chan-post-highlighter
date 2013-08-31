interval = null

chrome.runtime.onMessage.addListener (request, sender, sendResponse) ->
  return unless request.action is 'highlight_posts'

  clearInterval interval if interval?

  matcher = new RegExp request.matcher
  mobileMatch = /mobile/
  opMatch = /post op/

  sendResponse text: 'kay'

  highlightQuotes = ->
    for quoteLink in $ 'a[title="Quote this post"]'
      info = quoteLink.parentElement.parentElement
      continue if mobileMatch.test info.getAttribute 'class'
      post = info.parentElement
      continue if opMatch.test post.getAttribute 'class'
      postclass = "post reply#{if matcher.test quoteLink.innerHTML then ' highlight' else ''}"
      post.setAttribute 'class', postclass

  highlightQuotes()
  interval = setInterval highlightQuotes, 1000
