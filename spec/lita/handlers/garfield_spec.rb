require "spec_helper"

describe Lita::Handlers::Garfield, lita_handler: true do
  it 'will return a random garfield comic' do
    send '!garfield'
    expect(last_replies).to contain('https://garfield.com/uploads/strips/')
  end
  it 'will return today\'s garfield comic' do
    

  end
end
