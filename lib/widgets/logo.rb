# frozen_string_literal: true

module Widgets
  class Logo < Base
    LOGO = [
      '  _____ ___ _  _ ___  _   _  ',
      ' |_   _/ _ \ \/ / _ \| \ | | ',
      '   | || | | \  / | | |  \| | ',
      '   | || |_| /  \ |_| | |\  | ',
      '   |_| \___/_/\_\___/|_| \_| ',
      '                             ',
      '        Version 0.0.0        ',
      '                             ',
    ].freeze

    WIDTH  = LOGO.first.length
    HEIGHT = LOGO.length

    def initialize(parent, x, y, _width, _height)
      super parent, x, y, WIDTH, HEIGHT
    end

    def draw
      Style.default.logo window do
        LOGO.each_with_index do |s, index|
          setpos 0, index
          addstr s
        end
      end
    end
  end
end
