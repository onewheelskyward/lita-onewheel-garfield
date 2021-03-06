module Lita
  module Handlers
    class OnewheelGarfield < Handler
      route(/^garfield random$/i,
            :handle_random_garfield,
            command: true,
            help: { 'garfield random' => 'Get a random garfield comic.'})
      route(/^garfield$/i,
            :handle_default_garfield,
            command: true,
            help: { 'garfield' => 'Get today\'s garfield, or a random one if you\'ve already seen today\'s.'})
      route(/^garfield (\d{1,2})-(\d{1,2})-(\d{2,4})$/i,
            :handle_mdy_garfield,
            command: true,
            help: { 'garfield' => 'Get a garfield for a m/d/y date.'})
      route(/^garfield (\d{2,4})-(\d{1,2})-(\d{1,2})$/i,
            :handle_ymd_garfield,
            command: true,
            help: { 'garfield' => 'Get a garfield for a y-m-d date.'})
      route(/^garfield (\d{1,2})\/(\d{1,2})\/(\d{2,4})$/i,
            :handle_mdy_garfield,
            command: true,
            help: { 'garfield' => 'Get a garfield for a m-d-y date.'})
      route(/^garfield first$/i,
            :handle_first_garfield,
            command: true,
            help: { 'garfield first' => 'Get the first garfield comic.'})
      route(/^garfield last$/i,
            :handle_today_garfield,
            command: true,
            help: { 'garfield last' => 'Get the last garfield comic.'})
      route(/^garfield today$/i,
            :handle_today_garfield,
            command: true,
            help: { 'garfield today' => 'Get today\'s garfield comic.'})
      route(/^garfield prev$/i,
            :handle_prev_garfield,
            command: true,
            help: { 'garfield prev' => 'Get the previous garfield comic.'})
      route(/^garfield next$/i,
            :handle_next_garfield,
            command: true,
            help: { 'garfield next' => 'Get next garfield comic.'})

      def get_garfield_for_today(username)
        date = Date.today
        get_garfield_for_date(date, username)
      end

      def get_garfield_for_date(date, username)
        redis.set(username, date)
        "https://d1ejxu6vysztl5.cloudfront.net/comics/garfield/#{date.year}/#{date.year}-#{zero_prefix date.month}-#{zero_prefix date.day}.gif"
      end

      def zero_prefix(dat)
        if dat.to_i < 10
          "0#{dat}"
        else
          dat
        end
      end

      def handle_random_garfield(response)
        # get a random date between 1978-06-19 and now
        date = rand(Date.civil(1978, 6, 19)..Date.today())
        response.reply get_garfield_for_date(date, response.user.name)
      end

      def handle_default_garfield(response)
        response.reply get_garfield_for_today response.user.name
      end

      def handle_first_garfield(response)
        date = Date.civil(1978, 6, 19)
        response.reply get_garfield_for_date(date, response.user.name)
      end

      def handle_today_garfield(response)
        response.reply get_garfield_for_today response.user.name
      end

      def handle_ymd_garfield(response)
        date = Date.civil(response.match_data[1].to_i, response.match_data[2].to_i, response.match_data[3].to_i)
        response.reply get_garfield_for_date(date, response.user.name)
      end

      def handle_mdy_garfield(response)
        date = Date.civil(response.match_data[3].to_i, response.match_data[1].to_i, response.match_data[2].to_i)
        response.reply get_garfield_for_date(date, response.user.name)
      end

      def handle_next_garfield(response)
        date = Date.parse redis.get(response.user.name)
        unless date == Date.today
          date += 1
        end
        response.reply get_garfield_for_date(date, response.user.name)
      end

      def handle_prev_garfield(response)
        date = Date.parse redis.get(response.user.name)
        unless date == Date.civil(1978, 6, 19)
          date -= 1
        end
        response.reply get_garfield_for_date(date, response.user.name)
      end
    end

    Lita.register_handler(OnewheelGarfield)
  end
end
