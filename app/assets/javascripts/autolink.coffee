$ ->
  $.get('/words.json', (words) ->
    el = 'content'
    baseUrl = '/words'
    pattern = (word.replace(/\W/gi, '\\$&') for word in words).join('|')
    if document.getElementsByClassName("body").item(0) != null
      do_autolink(document.getElementsByClassName("body").item(0), new RegExp(pattern, 'gi'), baseUrl, add_class)
    if el
      do_autolink(document.getElementById(el), new RegExp(pattern, 'gi'), baseUrl)
  )

do_autolink = (element, regex, baseUrl, add_class) ->
  for node in element.childNodes
    if node.nodeType == 3
      new_value = node.nodeValue.replace(regex, (str, num, line) ->
        replace2(str, baseUrl, add_class)
      )
      if new_value != node.nodeValue
        new_node = document.createElement('span')
        new_node.innerHTML = new_value
        node.parentNode.replaceChild(new_node, node)
    else if node.nodeType == 1 && node.tagName!="A"
      do_autolink(node, regex, baseUrl, add_class)

replace2 = (str, baseUrl, add_class) ->
  $('<a></a>').addClass(add_class).addClass("autolink").attr("href", baseUrl+ "/" +  str).html(str)[0].outerHTML
