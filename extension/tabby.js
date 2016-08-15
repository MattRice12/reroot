;(function () {
    'use strict';

    // from the array of Tab objects it makes an object with date and the array
    function makeTabGroup(tabsArr) {
        var tabGroup = {
                date: new Date(),
                id: Date.now() // clever way to quickly get a unique ID
            };

        tabGroup.tabs = tabsArr;

        return tabGroup;
    }

    // filters tabGroup for stuff like pinned tabs, chrome:// tabs, etc.
    function filterTabGroup(tabGroup) {
        return tabGroup;
    }

    // saves array (of Tab objects) to localStorage
    function saveTabGroup(tabGroup) {
        chrome.storage.sync.get('tabGroups', function (storage) {
            var newArr;

            if (storage.tabGroups) {
                newArr = storage.tabGroups;
                newArr.push(tabGroup);

                chrome.storage.sync.set({ tabGroups: newArr });
            } else {
                chrome.storage.sync.set({ tabGroups: [ tabGroup ] });
            }
        });
    }
});
