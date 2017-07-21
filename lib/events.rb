# frozen_string_literal: true

module Events
  module Panel
    class Base; end

    class Up < Base; end
    class Down < Base; end
  end

  module Text
    class Base; end

    class Putc < Base
      attr_reader :char

      def initialize(char)
        raise TypeError unless char.is_a?(String) && char.size == 1
        @char = char.freeze
      end
    end

    class Left < Base; end
    class Right < Base; end
    class Home < Base; end
    class End < Base; end
    class Backspace < Base; end
    class Delete < Base; end
  end
end