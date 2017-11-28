//
// used to expand and contract the check list boxes by adjusting their outside containers
//
function btnExp_onclick(theButton) {
    var ArrowUp = "⇑";
    var ArrowDown = "⇓";

    var contractSize = "45px";
    var expandSize = "300px";

    var btnId = theButton.id;
    var expBarId = "expBar";
    var upWord = "up";
    var downWord = "down";

    var sizeToUse;

    direction = document.getElementById(btnId).dataset.dir;

    if (direction === downWord) {
        sizeToUse = expandSize;
        document.getElementById(btnId).dataset.dir = upWord;
        document.getElementById(btnId).value = ArrowUp;
        document.getElementById(btnId).innerHTML = ArrowUp;
        document.getElementById(btnId).innerText = ArrowUp;
    }
    else {
        sizeToUse = contractSize;
        document.getElementById(btnId).dataset.dir = downWord;
        document.getElementById(btnId).value = ArrowDown;
        document.getElementById(btnId).innerHTML = ArrowDown;
        document.getElementById(btnId).innerText = ArrowDown;
    }

    var idx = 0;
    var div;
    var divs = document.getElementsByClassName(expBarId);

    for (idx = 0; idx < divs.length; idx++) {
        div = divs[idx];
        div.style.height = sizeToUse;
    }

    return false;
};

//
// used to search the check box lists
// if it finds a hit and the item is selected it unselects it
// if it finds a hit and then item is unselected it selects it AND scrolls it to the top of the list
//
function List_KeyPress(theList) {
    var listId = theList.id;    
    var keyPressed = "";

    if (event.which === null) {

        keyPressed = String.fromCharCode(event.keyCode).toUpperCase();
    }
    else if (event.which !== 0 && event.charCode !== 0) {

        keyPressed = String.fromCharCode(event.which).toUpperCase();
    }
    else {

        return;
    }
    
    var listEle = document.getElementById(listId);
    var checkSet = listEle.firstElementChild;
    var setItems = checkSet.childNodes;
    
    var idx = 0;

    for (idx = 0; idx < setItems.length - 1; idx++) {

        if (setItems[idx] === null || setItems[idx].innerText === "") {

            return;

        }

        var lstText = setItems[idx].innerText.toString().toUpperCase();
        if (lstText.substring(0, 1) !== keyPressed) {

            continue;
        }

        if (setItems[idx].childNodes[1].childNodes[0].checked === true) {

            setItems[idx].childNodes[1].childNodes[0].checked = false;
        }
        else {

            setItems[idx].childNodes[1].childNodes[0].checked = true;
            setItems[idx].cells[0].scrollIntoView();
            break;
        }
    }

    return false;
};
