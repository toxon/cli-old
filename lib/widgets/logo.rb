# frozen_string_literal: true

module Widgets
  class Logo < React::Component
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

    def draw
      elem = render
      React::Curses::Nodes.klass_for(elem).new(nil, elem).draw
    end

    def render
      create_element :window, x: props[:x], y: props[:y], width: props[:width], height: props[:height] do
        create_element :lines do
          LOGO.each_with_index do |s|
            create_element :line do
              create_element :text, text: s, attr: Style.default.logo_attr
            end
          end
        end
      end
    end
  end
end
