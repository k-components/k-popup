# note: we could just use translate to position the popup, but iOS has a bug in it.

module.exports = class Popup
	view: __dirname
	name: 'k-popup'

	destroy: ->	@removeKeydownEvent()

	create: ->
		@model.set 'top', 'auto'
		@model.set 'right', 'auto'
		@model.set 'marginleft', '0'

		element = @model.get('element')
		@el = if element then document.getElementById(element) else @popup.parentNode
		if @el
			@el.addEventListener 'click', @show, false
     
	show: (e) =>
		if !@model.get('show') and @el and e
			e.preventDefault()
			e.stopPropagation()

			if @model.get('absolute')
				@setPositionAbsolute()
			else
				@setPositionRelative()

			@model.set 'show', true
			@setKeydownEvent()

	hide: (e) =>
		h = =>
			@model.del 'show'
			@model.del 'hiding'

		@removeKeydownEvent()
		@model.set 'hiding', true, ->
			setTimeout h, 310

	setKeydownEvent: =>
		document.addEventListener 'keydown', @keydown, true

	removeKeydownEvent: =>
		document.removeEventListener 'keydown', @keydown, true

	setPositionAbsolute: =>
		rect = @el.getBoundingClientRect()
		@model.set 'top', rect.bottom + 10 + 'px'
		right = if rect.right + 125 > window.innerWidth then 10 else window.innerWidth - rect.right - 125
		@model.set 'right', right + 'px'

	setPositionRelative: =>
		rect = @el.getBoundingClientRect()
		marginleft = if rect.right + 125 > window.innerWidth then -125 - (rect.right + 125 - window.innerWidth) - 10 else -125
		@model.set 'marginleft', marginleft + 'px'

	keydown: (e) =>
		key = e.keyCode or e.which
		if key is 27
			e.stopPropagation()
			@hide()
