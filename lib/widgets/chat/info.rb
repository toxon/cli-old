# frozen_string_literal: true

module Widgets
  using Helpers

  class Chat < VPanel
    class Info < Curses::React::Component
      PUBLIC_KEY_LABEL = 'Public key: '

    private

      def render
        Curses::React::Nodes.create(
          create_element(:wrapper) do
            create_element :wrapper do
              create_element :text_line,
                             x: 0,
                             y: 0,
                             width: status_text.length,
                             text: status_text,
                             attr: status_attr
            end
          end,

          window,
        ).draw

        setpos status_text.length, 0

        addstr ' '
        Style.default.peer_info_name window do
          addstr props[:name]
        end
        addstr ' : '
        addstr props[:status_message]

        Curses::React::Nodes.create(
          create_element(:wrapper) do
            create_element :wrapper do
              create_element :text_line,
                             x: 0,
                             y: 1,
                             width: PUBLIC_KEY_LABEL.length,
                             text: PUBLIC_KEY_LABEL

              create_element :text_line,
                             x: PUBLIC_KEY_LABEL.length,
                             y: 1,
                             width: props[:width] - PUBLIC_KEY_LABEL.length,
                             text: props[:public_key]
            end
          end,

          window,
        ).draw
      end

      def status_text
        case props[:status]
        when Tox::UserStatus::NONE then '[Online]'
        when Tox::UserStatus::AWAY then '[Away]'
        when Tox::UserStatus::BUSY then '[Busy]'
        else '[Unknown]'
        end
      end

      def status_attr
        case props[:status]
        when Tox::UserStatus::NONE then Style.default.online_mark_attr
        when Tox::UserStatus::AWAY then Style.default.away_mark_attr
        when Tox::UserStatus::BUSY then Style.default.busy_mark_attr
        end
      end
    end
  end
end
