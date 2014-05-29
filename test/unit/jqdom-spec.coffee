fs = require "fs"
path = require "path"
jqdom = require "../../src/jqdom"
fixturePath = path.resolve __dirname, "../fixtures"
html = fs.readFileSync "#{fixturePath}/page.html", "utf8"

describe "jqdom", ->

  it "should parse HTML into a jQuery object", ->
    $ = jqdom html
    title = $('title').text()
    expect(title).toBe "Hello, world"

  it "can be instantiated multiple times, on different documents", ->
    altHtml = fs.readFileSync "#{fixturePath}/page-alt.html", "utf8"
    $1 = jqdom html
    $2 = jqdom altHtml
    expect($1('title').text()).toBe "Hello, world"
    expect($2('title').text()).toBe "Hello again, world"
    expect($1).not.toEqual $2

  it "supports :contains functionality", ->
    $ = jqdom(html)
    expect($('div:contains(Contains example)').length).toBe 1

  it "supports clone(), find() and remove() functionality", ->
    $ = jqdom(html)
    $el = $('.clone')
    $clonedEl = $el.clone().find('.remove').remove().end()
    expect($el.text().trim()).not.toBe $clonedEl.text().trim()