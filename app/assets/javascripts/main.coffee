$ ->
  $(document).on('keypress', (e) ->
    if e.which == 13 # enter
      location.href = "/words/#{window.getSelection().toString()}"
  )
