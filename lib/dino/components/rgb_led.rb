module Dino
  module Components
    class RgbLed < BaseComponent
      # options = {board: my_board, pins: {red: red_pin, green: green_pin, blue: blue_pin}
      def after_initialize(options={})
        raise 'missing pins[:red] pin' unless self.pins[:red]
        raise 'missing pins[:green] pin' unless self.pins[:green]
        raise 'missing pins[:blue] pin' unless self.pins[:blue]

        pins.each do |color, pin|
          set_pin_mode(:out, pin)
          analog_write(Board::LOW, pin)
        end
      end

      # Format: [R, G, B]
      COLORS = {
        red:     [255, 000, 000],
        green:   [000, 255, 000],
        blue:    [000, 000, 255],
        cyan:    [000, 255, 255],
        yellow:  [255, 255, 000],
        magenta: [255, 000, 255],
        white:   [255, 255, 255],
        off:     [000, 000, 000]
      }

      COLORS.each_key do |color|
        define_method(color) do
          analog_write(COLORS[color][0],  pins[:red])
          analog_write(COLORS[color][1],  pins[:green])
          analog_write(COLORS[color][2],  pins[:blue])
        end 
      end

      def blinky
        [:red, :green, :blue].cycle do |color|
          self.send(color)
          sleep(0.01)
        end
      end
    end
  end
end
