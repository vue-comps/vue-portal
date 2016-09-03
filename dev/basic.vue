<template lang="pug">
.container(style="background-color:lightgrey")
  p within container
  a(href="https://github.com/vue-comps/vue-portal/blob/master/dev/basic.vue") source
  br
  br
  button(@click="togglePortal") toggle portal to body
  br
  br
  button(@click="toggleTarget") change dynamic target
  portal(v-if="toggled" v-ref:portal1)
    p#p1 teleported to body. Message from parent scope: {{message}}
    button#b1(@click="onClick") click button
      tooltip#t1(anchor="e",style="background-color:white;border:1px solid black",v-bind:offset=20) works with custom components, too
  portal(target=".container2")
    p#p2 teleported to container2 by selector
  portal(v-bind:target="con3")
    p#p3 teleported to container3 by element reference
  portal(v-bind:target="dynamicTarget")
    p#p4(style="color:red") dynamic target: {{dynamicTarget}}
      span(v-if="!dynamicTarget") null
.container2(style="background-color: lightgrey;margin-top: 20px")
  p within container2

.container3(style="background-color: lightgrey;margin-top: 20px" v-el:con)
  p within container3
</template>

<script lang="coffee">
module.exports =
  components:
    "portal": require "../src/portal.vue"
    "tooltip": require "vue-comps-tooltip"
  data: ->
    toggled: true
    message: "it works!"
    con3: null
    dynamicTarget: ".container"
  methods:
    onClick: -> alert("method from parent scope: works!")
    togglePortal: -> @toggled = !@toggled
    toggleTarget: ->
      switch @dynamicTarget
        when ".container" then @dynamicTarget = ".container2"
        when ".container2" then @dynamicTarget = @con3
        when @con3 then @dynamicTarget = null
        when null then @dynamicTarget = ".container"
  ready: ->
    @con3 = @$els.con
</script>
