# frozen_string_literal: true

module Widgets
  class Text < Base
  private

    def draw
      total = props[:width] - 1
      start = [0, props[:cursor_pos] - total].max

      cut = props[:text][start...start + total]

      setpos 0, 0

      before_cursor = cut[0...props[:cursor_pos]]
      under_cursor  = cut[props[:cursor_pos]] || ' '
      after_cursor  = cut[(1 + props[:cursor_pos])..-1] || ''

      Style.default.editing_text window do
        addstr before_cursor
      end

      Style.default.public_send props[:focused] ? :cursor : :editing_text, window do
        addstr under_cursor
      end

      Style.default.editing_text window do
        addstr after_cursor
      end
    end
  end
end
