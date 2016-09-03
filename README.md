# vue-portal

teleports the content to another location in the dom. Similar to [vue-transfer-dom](https://github.com/rhyzx/vue-transfer-dom) and [vue-move-dom](https://github.com/BosNaufal/vue-move-dom), but as a component instead of a directive.

### [Demo](https://vue-comps.github.io/vue-portal)


# Install

```sh
npm install --save-dev vue-portal
```
or include `build/bundle.js`.

## Usage
```coffee
# in your component
components:
  "portal": require("vue-portal")
# or, when using bundle.js
components:
  "portal": window.vueComps.portal
```
```html
<portal>
  <span>Will be appended to body</span>
</portal>
<portal target="#somewhere">
  <span>Will be appended to element with ID somewhere</span>
</portal>
```

For examples see [`dev/`](dev/).

#### Props
Name | type | default | description
---:| --- | ---| ---
target | String or Element | - | where the content will be appended. Defaults to `document.body`. Uses `document.querySelector` to convert a String to Element.

## Behavior

Works with `v-if` but not `v-show` on `<portal>`.
```html
<portal v-if="active">
  <span>Will be appended to body</span>
</portal>
<portal>
  <span v-show="active">Will be appended to element with ID somewhere</span>
</portal>
```

`target` prop can be dynamic.

# Development
Clone repository.
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## License
Copyright (c) 2016 Paul Pflugradt
Licensed under the MIT license.
