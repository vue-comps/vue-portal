// out: ..
<template lang="pug">
span
</template>

<script lang="coffee">
module.exports =
  mixins: [
    require "vue-mixins/vue"
    require "vue-mixins/fragToString"
  ]

  props: ["target"]


  computed:
    cTarget: ->
      if typeof @target == "string" or @target instanceof String
        return document.querySelector(@target)
      else if @target?
        return @target
      else
        return document.body
  watch:
    target: ->
      if @cTarget?
        if @frag? and @anchor
          @cTarget.appendChild(@anchor)
          @frag.before(@anchor)
        else
          @remove()
          @append()
  methods:
    append: ->
      @remove() if @frag?
      if @factory? and @cTarget?
        c = @_context
        @frag = @factory.create(@,c,null)
        @anchor = @Vue.util.createAnchor("vue-portal")
        @cTarget.appendChild(@anchor)
        @frag.before(@anchor)
    remove: ->
      @frag?.remove()
      @frag = null

  ready: ->
    frag = @_slotContents?.default
    if frag? and frag.childNodes?
      @factory = new @Vue.FragmentFactory @_context, @fragToString(frag)
      @append()
  beforeDestroy: -> @remove()
</script>
