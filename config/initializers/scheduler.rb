=begin
require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

# jobs go below here.

scheduler.every '10m' do
  # do stuff
  puts 'Entered scheduler method'
  Rental.schedulerTest
  puts 'Exited scheduler method'
end
=end
