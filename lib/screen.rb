# frozen_string_literal: true

require 'curses'

# Additional classes
require 'events'
require 'style'

# Basic
require 'widgets/base'
require 'widgets/text'

# Basic containers
require 'widgets/container'
require 'widgets/v_panel'

require 'widgets/main'
require 'widgets/sidebar'
require 'widgets/logo'
require 'widgets/menu'

require 'widgets/chat'
require 'widgets/chat/info'
require 'widgets/chat/history'
require 'widgets/chat/new_message'

class Screen
  attr_reader :window

  def initialize
    Curses.init_screen
    Curses.start_color
    Curses.noecho # do no echo input
    Curses.curs_set 0 # invisible cursor
    Curses.timeout = 0 # non-blocking input
    Curses.stdscr.keypad = true

    @window ||= Widgets::Main.new nil
  end

  def close
    Curses.close_screen
  end

  def props=(value)
    window.props = value
  end

  def render
    window.render
    Curses.refresh
  end

  def poll
    loop do
      ch = Curses.getch
      break if ch.nil?
      event = create_event ch
      next if event.nil?
      window.trigger event
    end
  end

private

  def create_event(char)
    case char
    when Curses::Key::SLEFT
      Events::Window::Left.new
    when Curses::Key::SRIGHT
      Events::Window::Right.new

    when Curses::Key::LEFT
      Events::Text::Left.new
    when Curses::Key::RIGHT
      Events::Text::Right.new
    when Curses::Key::UP
      Events::Text::Up.new
    when Curses::Key::DOWN
      Events::Text::Down.new
    when Curses::Key::HOME
      Events::Text::Home.new
    when Curses::Key::END
      Events::Text::End.new
    when Curses::Key::BACKSPACE
      Events::Text::Backspace.new
    when Curses::Key::DC
      Events::Text::Delete.new

    when String
      Events::Text::Putc.new char
    end
  end
end