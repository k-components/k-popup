k-popup
========

Small popups attached to a "parent node" (will show underneath it).

```
npm i k-popup --save
```

```coffee
app.component require 'k-popup'
```

```css
@import '../../node_modules/k-popup'
```

##Usage

```html
    <k-popup element="popupparent">
      <p><a href="/profile">profile</a></p>
      <p><a href="/logout" data-router-ignore="">log out</a></p>
    </k-popup>
```


```html
<li id="popupparent">show popup</li>
```
