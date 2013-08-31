matcher = /4chan/i

chrome.tabs.onUpdated.addListener (tabId, info, tab) ->
  chrome.pageAction.show tabId if matcher.test tab.url

chrome.tabs.onActivated.addListener (activeInfo) ->
  await chrome.tabs.get activeInfo.tabId defer(tab)
  chrome.pageAction.show tab.Id if matcher.test tab.url
