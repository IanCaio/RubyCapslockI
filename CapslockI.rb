#!/usr/bin/ruby

# Capslock Indicator made in Ruby
# Author: Ian Caio

require 'ruby-libappindicator'

class Indicator < AppIndicator::AppIndicator
  def initialize(name, icon, category)
    super

    indicator_setup

    @capslock_state = false
  end

  def indicator_setup
    indicatormenu = Gtk::Menu.new

    indicatormenu_quit = Gtk::MenuItem.new("Quit")
    indicatormenu_quit.signal_connect("activate"){
      quit
    }
    indicatormenu.append(indicatormenu_quit)
    indicatormenu_quit.show

    set_menu(indicatormenu)
    set_status(AppIndicator::Status::ACTIVE)

    GLib::Timeout.add(300){
      update
    }
  end

  def quit
    Gtk::main_quit
  end

  def update
    get_capslock_state

    if @capslock_state == true
      set_icon(Indicator.indicator_icons[1])
    else
      set_icon(Indicator.indicator_icons[0])
    end

    true
  end

  def get_capslock_state
    xset_output = `xset q | grep LED`
    if xset_output =~ /.*LED mask:  [01]{7}0.*/
      @capslock_state = false
    else
      @capslock_state = true
    end
  end

  def self.indicator_icons
    @indicator_icons ||= [
      __dir__ + "/res/capslockOff.png",
      __dir__ + "/res/capslockOn.png"
    ]
  end
end

Gtk.init

indicator = Indicator.new("CapslockI", Indicator.indicator_icons[0], AppIndicator::Category::APPLICATION_STATUS)

Gtk.main
