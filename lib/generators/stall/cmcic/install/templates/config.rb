  # CM-CIC payment gateway configuration
  # Fill in the informations provided by your CM or CIC provider
  #
  config.payment.cmcic do |cmcic|
    cmcic.hmac_key = '' # Hmac key calculated with the js calculator
    cmcic.tpe = '' # TPE number
    cmcic.societe = '' # Your merchant name

    # Test or production mode, default to false, changes the payment
    # gateway target URL. By default, the test mode is activated in all
    # environments except for the production one
    #
    # cmcic.test_mode = !Rails.env.production?
  end

