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
    ###
            when 404
                #addText "That file could not be found"
            when 507
                # The user is over their Dropbox quota.
                #addText "You are over your storage quota. Delete some files and try again"
            when 503
                # Too many API requests. Tell the user to try again later.
                #addText "This application has made too many API requests. Please try again later."
            when 400
                # Bad input parameter
                #addText "Bad input parameter"
            when 403
                # Bad OAuth request
                #addText "Bad OAuth request"
            when 405
                # Request method not expected
                #addText "Invalid request method"
    ###
    dropboxError = (error) ->
        console.error error
        switch error.status
            when 401
                # User token expired
                authDropbox()
            else
                alert "Unknown Dropbox error"
    authDropbox = ->
        window.client = new Dropbox.Client key: "jxh5Mr8ZiRA=|WTAARuurMBz3FSi8VT4zPWQfBJLiQl0ya4kumP+UrQ=="
        # Find the local URL of the end page
        # Changes with every compile
        dropboxurl = window.location.href.split "/"
        dropboxurl.pop()
        dropboxurl.push "dropboxReceive.html"
        dropboxurl = dropboxurl.join "/"
        # Popups don't save user info
        #window.client.authDriver new Dropbox.Drivers.Popup receiverUrl: dropboxurl, rememberUser: yes
        window.client.authDriver new Dropbox.Drivers.Redirect rememberUser: yes
        window.client.authenticate (error, client) ->
            if error
                console.error error
                window.DBAuthed = no
                alert "Something went wrong with the authentication process."
                return
            window.DBAuthed = yes
            # List files in sidebar
            client.readdir "/", (error, files, folderStat, filesStat) ->
                $("#sidebar ul li").remove()
                if error
                    return dropboxError error
                print = []
                # Folders first
                for file in filesStat
                    if file.isFolder
                        about =
                            "Type": "folder"
                            "Name": file.name
                        about = JSON.stringify about
                        about = about.replace /\"/g, "&quot;"
                        $("#sidebar ul").append """<li data-about="#{about}" class="folder">#{file.name}/</li>"""
                # Files
                for file in filesStat
                    unless file.isFolder
                        about =
                            "Type": "file"
                            "Name": file.name
                            "Mime": file.mimeType
                            "Size": file.humanSize
                        about = JSON.stringify about
                        about = about.replace /\"/g, "&quot;"
                        $("#sidebar ul").append """<li data-about="#{about}">#{file.name}</li>"""
    authDropbox()