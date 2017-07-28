# frozen_string_literal: true

module Widgets
  using Helpers

  class Chat < VPanel
    class Info < Curses::React::Component
      PUBLIC_KEY_LABEL = 'Public key: '

    private

      def render
        elem = render_element

        Curses::React::Nodes.klass_for(elem).new(elem, window).draw
      end

      def render_element
        create_element :lines, width: props[:width] do
          create_element :line do
            create_element :text,
                           y: 0,
                           text: status_text,
                           attr: status_attr

            create_element :text, x: status_text.length, y: 0, width: 1, text: ' '

            create_element :text,
                           y: 0,
                           text: props[:name],
                           attr: Style.default.peer_info_name_attr

            create_element :text, y: 0, text: ' : '

            create_element :text,
                           y: 0,
                           text: props[:status_message]
          end

          create_element :line do
            create_element :text,
                           y: 1,
                           text: PUBLIC_KEY_LABEL

            create_element :text,
                           y: 1,
                           text: props[:public_key]
          end
        end
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
