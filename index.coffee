
module.exports = class Popup
	view: __dirname
	name: 'd-popup'

	create: ->
		elId = @model.get('element')
		if elId
			@el = document.getElementById elId
			if @el
				@el.addEventListener 'click', @show, false

	show: (e) =>
		console.log 'show', @el
		if @el and e
			e.preventDefault()
			e.stopPropagation()
			rect = @el.getBoundingClientRect()
			console.log rect, rect.bottom, (rect.left + (rect.width / 2))
			@model.set 'top', rect.bottom + 10
			@model.set 'left', (rect.left + (rect.width / 2)) - 125
			@model.set 'show', true

	hide: (e) =>
		h = =>
			@model.del 'show'
			@model.del 'hiding'

		@model.set 'hiding', true, ->
			setTimeout h, 310

	keydown: (e) =>
		key = e.keyCode or e.which
		@hide() if key is 27
