require "shellwords"
require "dmenu/item"

# @example A simple menu
#   menu = Dmenu.new
#   menu.items = ["foo", "bar", Dmenu::Item.new("baz", 123), ['spam', 'eggs']]
#
#   menu.run # this will return a Dmenu::Item, according to what the user selected.
class Dmenu
  VERSION = "0.0.2"

  # @return [Array<#to_s, Item>] Items to display in the menu. Items
  #   that are not an instance of the {Item} class will transparently
  #   be converted into one.
  attr_accessor :items
  # @return [Symbol<:top, :bottom>] Where to display the menu on screen.
  attr_accessor :position
  # @return [Boolean] If true, menu entries will be matched case insensitively.
  attr_accessor :case_insensitive
  # @return [Number] Number of lines to display. If >1, dmenu will go into vertical mode.
  attr_accessor :lines
  # @return [String] Which font to use.
  attr_accessor :font
  # @return [String] The background color of normal items.
  attr_accessor :background
  # @return [String] The foreground color of normal items.
  attr_accessor :foreground
  # @return [String] The background color of selected items.
  attr_accessor :selected_background
  # @return [String] The foreground color of selected items.
  attr_accessor :selected_foreground
  # @return [String] Defines a prompt to be displayed before the input area.
  attr_accessor :prompt
  def initialize
    @items               = []
    @position            = :top
    @case_insensitive    = false
    @lines               = 1
    @font                = nil
    @background          = nil
    @foreground          = nil
    @selected_background = nil
    @selected_foreground = nil
    @prompt              = nil
  end

  # Launches dmenu, displays the generated menu and waits for the user
  # to make a choice.
  #
  # @return [Item, nil] Returns the selected item or nil, if the user
  #   didn't make any selection (i.e. pressed ESC)
  def run
    command = "dmenu #{args}"
    pipe = IO.popen(command, "w+")

    items = @items.map {|item|
      if item.is_a?(Item)
        item
      elsif item.is_a?(Array)
        Item.new(item[0], item[1])
      else
        Item.new(item, item)
      end
    }

    items.each do |item|
      pipe.puts item.key.to_s
    end

    pipe.close_write
    value = pipe.read
    pipe.close

    if $?.exitstatus > 0
      return nil
    end

    selection = items.find {|item|
      item.key.to_s == value
    }

    return selection
  end

  def args
    args = []
    args << "-b" if @position == :bottom
    args << "-i" if @case_insensitive
    args << "-l #@lines" if @lines > 1
    args << "-fn " + Shellwords.escape(@font)  if @font
    args << "-nb " + Shellwords.escape(@background) if @background
    args << "-nf " + Shellwords.escape(@foreground) if @foreground
    args << "-sb " + Shellwords.escape(@selected_background) if @selected_background
    args << "-sf " + Shellwords.escape(@selected_foreground) if @selected_foreground
    args << "-p " + Shellwords.escape(@prompt) if @prompt

    args.join(" ")
  end
  private :args
end
