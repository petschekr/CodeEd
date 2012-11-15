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