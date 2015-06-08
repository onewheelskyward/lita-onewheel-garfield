module Lita
  module Handlers
    class Garfield < Handler
      route(/^!garfield random$/i, :handle_random_garfield,
        help: { '!garfield random' => 'Get a random garfield comic.'})
      route(/^!garfield$/i, :handle_default_garfield,
        help: { '!garfield' => 'Get today\'s garfield, or a random one if you\'ve already seen today\'s.'})
      route(/^!garfield (\d{1,2})-(\d{1,2})-(\d{2,4})$/i, :handle_mdy_garfield,
        help: { '!garfield' => 'Get a garfield for a m/d/y date.'})
      route(/^!garfield (\d{2,4})-(\d{1,2})-(\d{1,2})$/i, :handle_ymd_garfield,
        help: { '!garfield' => 'Get a garfield for a y-m-d date.'})
      route(/^!garfield (\d{1,2})\/(\d{1,2})\/(\d{2,4})$/i, :handle_mdy_garfield,
        help: { '!garfield' => 'Get a garfield for a m-d-y date.'})
      route(/^!garfield first$/i, :handle_first_garfield,
        help: { '!garfield first' => 'Get the first garfield comic.'})
      route(/^!garfield last$/i, :handle_today_garfield,
        help: { '!garfield last' => 'Get the last garfield comic.'})
      route(/^!garfield today$/i, :handle_today_garfield,
        help: { '!garfield today' => 'Get today\'s garfield comic.'})

      def get_garfield_for_today
        date = Date.today
        get_garfield_for_date(date.month, date.day, date.year)
      end

      def get_garfield_for_date(month, day, year)
        "https://garfield.com/uploads/strips/#{year}-#{zero_prefix month}-#{zero_prefix day}.jpg"
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
        response.reply get_garfield_for_date(date.month, date.day, date.year)
      end

      def handle_default_garfield(response)
        response.reply get_garfield_for_today
      end

      def handle_first_garfield(response)
        response.reply get_garfield_for_date(6, 19, 1978)
      end

      def handle_today_garfield(response)
        response.reply get_garfield_for_today
      end

      def handle_ymd_garfield(response)
        response.reply get_garfield_for_date(response.match_data[2], response.match_data[3], response.match_data[1])
      end

      def handle_mdy_garfield(response)
        response.reply get_garfield_for_date(response.match_data[1], response.match_data[2], response.match_data[3])
      end
    end

    Lita.register_handler(Garfield)
  end
end
