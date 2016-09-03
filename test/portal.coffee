env = null
basic = require("../dev/basic.vue")
get = (s) -> document.querySelector(s)
event = (e,s,cb) ->
  ev = document.createEvent( 'CustomEvent' )
  ev.initCustomEvent( s, false, false, null )
  e.dispatchEvent(ev)
  env.$nextTick cb
describe "portal", ->

  describe "basic env", ->

    before (done) ->
      basic.compiled = ->
        @onClick = chai.spy("button click")
      env = loadComp(basic)
      env.$nextTick ->
        done()

    after ->
      unloadComp(env)

    it "should default to document.body", ->
      p1 = get("#p1")
      should.exist p1
      p1.parentNode.should.equal document.body
      b1 = get("#b1")
      should.exist b1
      b1.parentNode.should.equal document.body

    it "should work with selector string", ->
      p2 = get("#p2")
      should.exist p2
      p2.parentNode.should.equal get(".container2")
      p3 = get("#p3")
      should.exist p3

    it "should work with element reference", ->
      p3 = get("#p3")
      should.exist p3
      p3.parentNode.should.equal get(".container3")

    it "should work v-if", (done) ->
      should.exist get("#p1")
      should.exist get("#b1")
      env.toggled = false
      env.$nextTick ->
        should.not.exist get("#p1")
        should.not.exist get("#b1")
        env.toggled = true
        env.$nextTick ->
          p1 = get("#p1")
          should.exist p1
          p1.parentNode.should.equal document.body
          b1 = get("#b1")
          should.exist b1
          b1.parentNode.should.equal document.body
          done()

    it "should be possible to call methods in parent scope", ->
      b1 = get("#b1")
      should.exist b1
      b1.click()
      env.onClick.should.have.been.called.once

    it "should work with custom components", (done) ->
      should.not.exist get("#t1")
      b1 = get("#b1")
      should.exist b1
      event b1,"mouseenter", ->
        should.exist get("#t1")
        event b1,"mouseleave", ->
          should.not.exist get("#t1")
          done()

    it "should work with dynamic target", (done) ->
      should.exist get("#p1")
      b1 = get("#b1")
      should.exist b1
      event b1,"mouseenter", ->
        should.exist get("#t1")
        container = get(".container")
        env.$refs.portal1.target = container
        env.$nextTick ->
          should.exist get("#t1")
          p1 = get("#p1")
          should.exist p1
          p1.parentNode.should.equal container
          b1 = get("#b1")
          should.exist b1
          b1.parentNode.should.equal container
          event b1,"mouseleave", ->
            should.not.exist get("#t1")
            done()
