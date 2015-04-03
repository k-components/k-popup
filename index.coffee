
module.exports = class Popup
	view: __dirname
	name: 'k-popup'

	create: ->
		elId = @model.get('element')
		if elId
			@el = document.getElementById elId
			if @el
				@el.addEventListener 'click', @show, false

	show: (e) =>
		if @el and e
			e.preventDefault()
			e.stopPropagation()
			window.addEventListener 'resize', @resize, false
			@setPosition()
			@model.set 'show', true

	hide: (e) =>
		h = =>
			@model.del 'leftborder'
			@model.del 'show'
			@model.del 'hiding'

		window.removeEventListener 'resize', @resize
		@model.set 'hiding', true, ->
			setTimeout h, 310

	setPosition: =>
		rect = @el.getBoundingClientRect()
		@model.set 'top', rect.bottom + 10
		left = (rect.left + (rect.width / 2)) - 125
		if left < 0
			left = 10
			@model.set 'leftborder', 'leftborder'
		else
			@model.del 'leftborder'
		@model.set 'left', left

	resize: (e) =>
		@setPosition()

	keydown: (e) =>
		key = e.keyCode or e.which
		@hide() if key is 27
