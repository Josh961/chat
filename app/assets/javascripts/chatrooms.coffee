# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).on 'turbolinks:load', ->
  $messages = $('#all-messages')
  $header = $('#header')
  $new_message_form = $('#new-message')
  $new_message_body = $new_message_form.find('#contents')
  $chat_room_name = $('#chat_room_name').val()
  $new_message_attachment = $new_message_form.find('#message-attachment')

  if $messages.length > 0

    messages_to_bottom = -> $messages.scrollTop($messages.prop("scrollHeight"))
    messages_to_bottom()

    App.chat = App.cable.subscriptions.create {
      channel: "ChatChannel", room: $chat_room_name

    # App.chat = App.cable.subscriptions.create {
    #  channel: "ChatChannel"
    },
      connected: ->

      disconnected: ->

      received: (data) ->
        console.log(data['current_room'])
        console.log($header)
        console.log($header.text())
        if data['message'] && data['current_room'] == $header.text()
          $messages.append data['message']
          messages_to_bottom()

      send_message: (message, current_room, file_uri, original_name) ->
        @perform 'send_message', message: message, current_room: current_room, file_uri: file_uri, original_name: original_name

    $new_message_form.submit (e) ->
      $this = $(this)
      contents = $new_message_body.val()
      if $new_message_attachment.get(0).files.length > 0 # if file is chosen
        reader = new FileReader()  # use FileReader API
        file_name = $new_message_attachment.get(0).files[0].name # get the name of the first chosen file
        reader.addEventListener "loadend", -> # perform the following action after the file is loaded
          App.chat.send_message contents, $header.text(), reader.result, file_name
          $new_message_attachment.val('')

        reader.readAsDataURL $new_message_attachment.get(0).files[0] # read the chosen file
      else
        App.chat.send_message contents, $header.text()

      e.preventDefault()
      return false
