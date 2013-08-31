class PostHighlighter
  Object.defineProperty @::, "mode",
    get: -> highlight_mode_select.options[highlight_mode_select.selectedIndex].value

  on_highlight_mode_changed: ->
    if PostHighlighter::mode is 'ends'
      console.log post_ends_with
      post_ends_with.setAttribute 'style', 'width: 150px'
    else
      post_ends_with.setAttribute 'style', 'width: 150px; display: none'

  highlight: ->
    switch PostHighlighter::mode
      when "dubs" then PostHighlighter::highlight_dubs()
      when "trips" then PostHighlighter::highlight_trips()
      when "ends" then PostHighlighter::highlight_ends post_ends_with.value

  highlight_ends: (ending) ->
    matcher = "(#{ending})$"
    PostHighlighter::highlight_posts matcher

  highlight_dubs: ->
    matcher = "(00|11|22|33|44|55|66|77|88|99)$"
    PostHighlighter::highlight_posts matcher

  highlight_trips: ->
    matcher = "(000|111|222|333|444|555|666|777|888|999)$"
    PostHighlighter::highlight_posts matcher

  highlight_posts: (matcher) ->
    await chrome.tabs.query active: yes, currentWindow: yes, defer(tabs)
    chrome.tabs.sendMessage tabs[0].id, action: 'highlight_posts', matcher: matcher

  highlight_mode_select = document.getElementById 'highlight_mode_select'
  highlight_mode_select.addEventListener 'change', PostHighlighter::on_highlight_mode_changed

  post_ends_with = document.getElementById 'post_ends_with'
  post_ends_with.setAttribute 'style', 'width: 150px; display: none'

  highlight_btn = document.getElementById 'highlight_btn'
  highlight_btn.addEventListener 'click', PostHighlighter::highlight
