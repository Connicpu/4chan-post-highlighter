matcher = new RegExp "^http(s)?\://boards.4chan.org/([a-z]{1,3})/", 'i'

chrome.tabs.onUpdated.addListener (tabId, info, tab) ->
  chrome.pageAction.show tabId if matcher.test tab.url

chrome.tabs.onActivated.addListener (activeInfo) ->
  await chrome.tabs.get activeInfo.tabId defer(tab)
  chrome.pageAction.show tab.Id if matcher.test tab.url
