
module.exports = class Popup
	view: __dirname
	name: 'k-popup'

	destroy: -> @removeKeydownEvent()

	create: ->
		@model.set 'top', 'auto'
		@model.set 'left', 'auto'
		element = @model.get('element')
		@el = if element then document.getElementById(element) else @popup.parentNode
		if @el
			@el.addEventListener 'click', @show, false

	show: (e) =>
		if !@model.get('show') and @el and e
			e.preventDefault()
			e.stopPropagation()

			if @model.get('pos')
				@setPosition()

			@model.set 'show', true
			@setKeydownEvent()

	hide: (e) =>
		h = =>
			@model.del 'leftborder'
			@model.del 'show'
			@model.del 'hiding'

		@removeKeydownEvent()
		@model.set 'hiding', true, ->
			setTimeout h, 310

	setKeydownEvent: =>
		document.addEventListener 'keydown', @keydown, true

	removeKeydownEvent: =>
		document.removeEventListener 'keydown', @keydown

	setPosition: =>
		rect = @el.getBoundingClientRect()
		@model.set 'top', rect.bottom + 10 + 'px'
		adjust = if rect.right + 125 > window.innerWidth then rect.right + 125 - window.innerWidth else 0
		@model.set 'left', (rect.left - adjust) + 'px'

	keydown: (e) =>
		key = e.keyCode or e.which
		@hide() if key is 27
