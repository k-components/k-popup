/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS206: Consider reworking classes to avoid initClass
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/main/docs/suggestions.md
 */
// note: we could just use translate to position the popup, but iOS has a bug in it.

let Popup;
module.exports = (Popup = (function() {
	Popup = class Popup {
		constructor() {
			this.show = this.show.bind(this);
			this.hide = this.hide.bind(this);
			this.setKeydownEvent = this.setKeydownEvent.bind(this);
			this.removeKeydownEvent = this.removeKeydownEvent.bind(this);
			this.setBottom = this.setBottom.bind(this);
			this.setPositionAbsolute = this.setPositionAbsolute.bind(this);
			this.setPositionRelative = this.setPositionRelative.bind(this);
			this.keydown = this.keydown.bind(this);
		}

		static initClass() {
			this.prototype.view = __dirname;
			this.prototype.name = 'k-popup';
		}

		destroy() {
			this.removeKeydownEvent();
			if (this.el) {
				return this.el.removeEventListener('click', this.show, false);
			}
		}

		create() {
			this.model.set('top', 'auto');
			this.model.set('right', 'auto');
			this.model.set('marginleft', '0');

			const element = this.model.get('element');
			this.el = element ? document.getElementById(element) : this.popup.parentNode;
			if (this.el) {
				return this.el.addEventListener('click', this.show, false);
			}
		}
     
		show(e) {
			if (!this.model.get('show') && this.el && e) {
				e.preventDefault();
				e.stopPropagation();

				if (this.model.get('absolute')) {
					this.setPositionAbsolute();
				} else {
					this.setPositionRelative();
				}

				this.model.set('show', true);
				this.emit('show');
				return this.setKeydownEvent();
			}
		}

		hide(e) {
			const h = () => {
				this.model.del('show');
				this.model.del('hiding');
				return this.emit('hide');
			};

			this.removeKeydownEvent();
			return this.model.set('hiding', true, () => setTimeout(h, 310));
		}

		setKeydownEvent() {
			return document.addEventListener('keydown', this.keydown, true);
		}

		removeKeydownEvent() {
			return document.removeEventListener('keydown', this.keydown, true);
		}

		setBottom(rect) {
			if ((rect.bottom + 200) > window.innerHeight) {
				return this.model.set('above', 1);
			}
		}

		setPositionAbsolute() {
			const rect = this.el.getBoundingClientRect();
			let left = Math.max(10, (rect.left - 125) + (rect.width / 2)) + 2;

			if ((window.innerWidth - (left + 250)) < 0) {
				left += window.innerWidth - (left + 250) - 10;
			}

			this.model.set('left', `${left}px`);
			return this.model.set('top', rect.bottom + 10 + 'px');
		}

		setPositionRelative() {
			const rect = this.el.getBoundingClientRect();
			const marginleft = (rect.right + 125) > window.innerWidth ? (-125 - ((rect.right + 125) - window.innerWidth) - 10) : (-125 + (this.el.offsetWidth / 2));
			this.model.set('marginleft', marginleft + 'px');
			return this.setBottom(rect);
		}

		keydown(e) {
			const key = e.keyCode || e.which;
			if (key === 27) {
				e.stopPropagation();
				return this.hide();
			}
		}
	};
	Popup.initClass();
	return Popup;
})());
