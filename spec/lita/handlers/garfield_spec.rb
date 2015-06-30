require 'spec_helper'

describe Lita::Handlers::Garfield, lita_handler: true do

  it { is_expected.to route_command('garfield') }
  it { is_expected.to route_command('garfield random') }
  it { is_expected.to route_command('garfield first') }
  it { is_expected.to route_command('garfield last') }
  it { is_expected.to route_command('garfield today') }
  it { is_expected.to route_command('garfield 5/5/1998') }
  it { is_expected.to route_command('garfield 5-5-1998') }
  it { is_expected.to route_command('garfield 1998-5-5') }
  it { is_expected.to route_command('garfield prev') }
  it { is_expected.to route_command('garfield next') }

  def zero_prefix(dat)
    if dat.to_i < 10
      "0#{dat}"
    else
      dat
    end
  end

  def get_todays_image_filename
    date = Date.today
    "#{date.year}-#{zero_prefix date.month}-#{zero_prefix date.day}"
  end

  it 'will return a random garfield comic' do
    send_command 'garfield random'
    expect(replies.last).to include('https://garfield.com/uploads/strips/')
  end

  it 'will return a today\'s then a random garfield comic' do
    send_command 'garfield'
    expect(replies.last).to include("https://garfield.com/uploads/strips/#{get_todays_image_filename}.jpg")
    send_command 'garfield'
    expect(replies.last).to include('https://garfield.com/uploads/strips/')
  end

  it 'will return today\'s garfield comic' do
    send_command 'garfield today'
    expect(replies.last).to include("https://garfield.com/uploads/strips/#{get_todays_image_filename}.jpg")
  end

  it 'will return today\'s garfield comic' do
    send_command 'garfield last'
    expect(replies.last).to include("https://garfield.com/uploads/strips/#{get_todays_image_filename}.jpg")
  end

  it 'will return the first garfield comic' do
    send_command 'garfield first'
    expect(replies.last).to include('https://garfield.com/uploads/strips/1978-06-19.jpg')
  end

  it 'will return a garfield comic for a specific y-m-d date' do
    send_command 'garfield 1998-5-5'
    expect(replies.last).to include('https://garfield.com/uploads/strips/1998-05-05.jpg')
  end

  it 'will return a garfield comic for a specific m-d-y date' do
    send_command 'garfield 5-5-1998'
    expect(replies.last).to include('https://garfield.com/uploads/strips/1998-05-05.jpg')
  end

  it 'will return a garfield comic for a specific / date' do
    send_command 'garfield 5/5/1998'
    expect(replies.last).to include('https://garfield.com/uploads/strips/1998-05-05.jpg')
  end

  # Test the saved state of the last comic you requested.
  it 'will return the first and then the next and then the previous garfield comic' do
    send_command 'garfield first'
    expect(replies.last).to include('https://garfield.com/uploads/strips/1978-06-19.jpg')
    send_command 'garfield next'
    expect(replies.last).to include('https://garfield.com/uploads/strips/1978-06-20.jpg')
    send_command 'garfield prev'
    expect(replies.last).to include('https://garfield.com/uploads/strips/1978-06-19.jpg')
  end

  it 'will edge case prev and next' do
    today = Date.today

    first = 'https://garfield.com/uploads/strips/1978-06-19.jpg'
    last = "https://garfield.com/uploads/strips/#{today.year}-#{zero_prefix today.month}-#{zero_prefix today.day}.jpg"

    send_command 'garfield first'
    expect(replies.last).to include(first)
    send_command 'garfield prev'
    expect(replies.last).to include(first)
    send_command 'garfield last'
    expect(replies.last).to include(last)
    send_command 'garfield next'
    expect(replies.last).to include(last)
  end
end
