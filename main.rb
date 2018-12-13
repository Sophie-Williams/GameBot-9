require 'elephrame'
require 'time'

game_bot = Elephrame::Bots::PeriodInteract.new '3h'

game_bot.on_reply { |bot|
  # collecting all the mentions now happens in the framework itself,
  #  so we can simplify our code! :3
  bot.reply_with_mentions("you just lost The Game",
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
