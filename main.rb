require 'elephrame'
require 'time'

game_bot = Elephrame::Bots::PeriodInteract.new '3h'

game_bot.on_reply { |bot, mention|

  # collect all the mentions, so we can @ them
  #  unless they have #NoBot specified in their bio
  #  (don't want to be rude)
  # also prepend the account who @ed the bot
  #  it doesn't matter if they have #NoBot, bc
  #  they're the ones who @ed us in the first place!
  ments = mention.mentions.collect { |m|
    "@#{m.acct}" unless m.acct == bot.username or bot.no_bot? m.id
  }.prepend "@#{mention.account.acct}"

  bot.reply("#{ments.join(' ')} you just lost The Game",
            spoiler: 'cognitohazard')
}

game_bot.run { |bot|
  # make a post to the public timeline,
  # making sure we tag it correctly
  bot.post('The Game', spoiler: 'cognitohazard',
           visibility: 'public')

  # change the next post time to somewhere
  #  between now and 6 hours from now
  bot.schedule.next_time = Time.now + rand() * 6 * 3600
}
