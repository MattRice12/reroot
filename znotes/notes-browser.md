##Add to manifest.json
Manifest
You must declare the "history" permission in the extension manifest to use the history API. For example:

      {
        "name": "My extension",
        ...
        "permissions": [
          "history"
        ],
        ...
      }

##When the tab is created / updated
  onCreated

  Fired when a tab is created. Note that the tab's URL may not be set at the time this event fired, but you can listen to onUpdated events to be notified when a URL is set.

    addListener
    chrome.tabs.onCreated.addListener(function callback)


  onUpdated

  Fired when a tab is updated.

    addListener
    chrome.tabs.onUpdated.addListener(function callback)

##Send a message to the content script in the specified tab
  sendMessage

  chrome.tabs.sendMessage(integer tabId, any message, object options, function responseCallback)

  Sends a single message to the content script(s) in the specified tab, with an optional callback to run when a response is sent back. The runtime.onMessage event is fired in each content script running in the specified tab for the current extension.


##Grabbing all tabs
  query

  chrome.tabs.query(object queryInfo, function callback)

  Gets all tabs that have the specified properties, or all tabs if no properties are specified.


##Storing a URL
  onVisited

  Fired when a URL is visited, providing the HistoryItem data for that URL. This event fires before the page has loaded.

  addListener
  chrome.history.onVisited.addListener(function callback)



##Store History
  addUrl

  chrome.history.addUrl(object details, function callback)
  Adds a URL to the history at the current time with a transition type of "link".


##Delete URL (maybe for deleting duplicates, or when a user deletes one url)
  deleteUrl

  chrome.history.deleteUrl(object details, function callback)
  Removes all occurrences of the given URL from the history.
