Given /^I am not yet playing$/ do
end

When /^I start a new game$/ do
  game = Codebreaker::Game.new(input, output)
  game.start('1234')
end

Then /^I should see "(.*?)" "(.*?)"$/ do |message, secret|
  output.messages.should include(message + secret)
end

When /^there have been more than (\d+) turns$/ do |turns|
  (0..7).each do |turn |
    @input.puts('1111') 
  end
  @game.go(7)
end

When /^there have been less than (\d+) turns$/ do |arg1|
    @input.puts('1111') 
end

Then /^I should see "([^"]*)"$/ do |message|
  output.messages.should include(message)
end

Given /^the secret code is "(.*?)"$/ do |secret|
  @input = Input.new
  @game = Codebreaker::Game.new(@input, output)
  @game.start(secret)
end

When /^I guess "(.*?)"$/ do |guess|
  @output.puts "about to guess #{guess}"
  @input.puts(guess)
  @game.go(1)
end

Then /^the mark should be "(.*?)"$/ do |mark|
  output.messages.should include(mark)
end
class Output
  def messages
    @messages ||= []
  end
  def puts(message)
    messages << message
  end
end
def output
  @output ||= Output.new
end
class Input
  def initialize
    @messages = Array.new
  end
  def messages
    @messages ||= []
  end
  def puts(message)
    # puts "Input class: adding message #{message}"
    @messages << message
  end
  def gets()
    @messages.pop
  end
end
def input
  @input ||= Input.new
end
