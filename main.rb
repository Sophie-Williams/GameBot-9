require 'elephrame'
require 'time'

game_bot = Elephrame::Bots::PeriodInteract.new '3h'

game_bot.on_reply { |bot, mention|
  ments = mention.mentions.collect { |m|
    "@#{m.acct}" unless m.acct == bot.username or bot.no_bot? m.id
  }.prepend "@#{mention.account.acct}"
  
  bot.reply("#{ments.join(' ')} you just lost The Game",
            spoiler: 'cognitohazard')
}

game_bot.run { |bot|
  bot.post('The Game', spoiler: 'cognitohazard',
           visibility: 'public')
  bot.schedule.next_time = Time.now + rand() * 6 * 3600
}
