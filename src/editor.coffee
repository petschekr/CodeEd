###
gui = require "nw.gui"
menu = new gui.Menu type: "menubar"

menu.append new gui.MenuItem label: "Item A"
menu.append new gui.MenuItem type: "separator"
menu.append new gui.MenuItem label: "Item B"

gui.Window.get().menu = menu
###
$ ->
    window.CodeMirrorObj = CodeMirror document.getElementById("code"), {
        mode: "text/html"
        theme: "brackets"
        indentUnit: 4
        tabSize: 4
        lineWrapping: on
        lineNumbers: yes
        matchBrackets: yes
        undoDepth: 60
        extraKeys:
            "'>'": (cm) -> cm.closeTag(cm, '>')
            "'/'": (cm) -> cm.closeTag(cm, '/')
    }
    authDropbox = ->
        window.client = new Dropbox.Client key: "jxh5Mr8ZiRA=|WTAARuurMBz3FSi8VT4zPWQfBJLiQl0ya4kumP+UrQ=="
        # Find the local URL of the end page
        # Changes with every compile
        dropboxurl = window.location.href.split "/"
        dropboxurl.pop()
        dropboxurl.push "dropboxReceive.html"
        dropboxurl = dropboxurl.join "/"
        window.client.authDriver new Dropbox.Drivers.Popup receiverUrl: dropboxurl, rememberUser: yes
        window.client.authenticate (error, client) ->
            if error
                console.error error
                window.DBAuthed = no
                alert "Something went wrong with the authentication process."
                return
            window.DBAuthed = yes
            alert "Authed went well"
    authDropbox()