module.exports =
  basicAuthPassword: process.env.BASIC_AUTH_PASSWORD || false
  basicAuthUsername: process.env.BASIC_AUTH_USERNAME || false
  enableCollector: process.env.ENABLE_COLLECTOR || 1
  enableEvaluator: process.env.ENABLE_EVALUATOR || 1
  mongoUrl: process.env.MONGODB_URL || 'mongodb://analytics:69UHwv2SUsu2SPPhcVuTvBrtvUMM6tw3@zoe.mongohq.com:10065/analytics_cobrajam'
  mongoUser: process.env.MONGODB_USERNAME || 'cube'
  mongoPass: process.env.MONGODB_PASSWORD || '4NZhaOn494KMbco0'
  port: process.env.PORT || 52345


  # Truthiness.
  is: (value) ->
    return false if !value?
    return false if !value
    switch value
      when "false", "FALSE", "0", "off", "OFF", "no", "NO" then false
      else true
