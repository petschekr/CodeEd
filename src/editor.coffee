$ ->
	window.CodeMirrorObj = CodeMirror document.getElementById("code"), {
		mode: "javascript"
		theme: "brackets"
		indentUnit: 4
		tabSize: 4
		lineWrapping: on
		lineNumbers: yes
		matchBrackets: yes
		undoDepth: 60
	}