# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  upload.setupForm()
  
upload = 
  setupForm: ->
    $('#new_upload').submit ->
      $('input[type=submit]').prop('disabled', true)
      if $('#card_number').length
        upload.processCard()
        false
      else
        true
        

  processCard: ->
    card = 
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, upload.handleStripeResponse)
    
  
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#upload_stripe_card_token').val(response.id)
      $('#new_upload')[0].submit()
    else
      $('#stripe-error-message.alert-message.block-message.error').text(response.status)
      $('input[type=submit]').attr('disabled', false)
      