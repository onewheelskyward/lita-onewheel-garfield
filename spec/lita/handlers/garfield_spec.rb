require "spec_helper"

describe Lita::Handlers::Garfield, lita_handler: true do
  it 'will return a random garfield comic' do
    send_message '!garfield random'
    expect(last_replies).to contain('https://garfield.com/uploads/strips/')
  end

  it 'will return a today\'s then a random garfield comic' do
    send_message '!garfield'
    expect(last_replies).to contain('https://garfield.com/uploads/strips/[today]')
    send_message '!garfield'
    expect(last_replies).to contain('https://garfield.com/uploads/strips/')
  end

  it 'will return today\'s garfield comic' do
    send_message '!garfield today'
    expect(last_replies).to contain('https://garfield.com/uploads/strips/[today]')
  end

  it 'will return the first garfield comic' do
    send_message '!garfield first'
    expect(last_replies).to contain('https://garfield.com/uploads/strips/[today]')
  end

  # Test the saved state of the last comic you requested.
  it 'will return the first and then the next garfield comic' do
    send_message '!garfield first'
    expect(last_replies).to contain('https://garfield.com/uploads/strips/1978-06-19.jpg')
    send_message '!garfield next'
    expect(last_replies).to contain('https://garfield.com/uploads/strips/1978-06-20.jpg')
  end
end
