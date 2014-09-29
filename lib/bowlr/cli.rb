require 'thor'

require 'bowlr/game'

module Bowlr
  class CLI < Thor
    attr_accessor :application

    desc 'start a bowling game', 'have fun!'
    def execute
      @application = Game.new
      instructions do |instruction|
        response = @application.hit(instruction)
        print response if response.is_a?(String)
      end
    end

    default_task :execute

    no_tasks do

      def instructions(&instruction)
        print "#{@application.usage}"
        print prompt
        read_from_command_line(&instruction)
      end

      def read_from_command_line(&instruction)
        while line = gets
          case line
          when /EXIT/i
            break
          when /HELP/i
            print "#{@application.usage}"
          else
            yield line
          end
          print prompt
        end
      end

      def prompt
        " \n> "
      end
    end
  end
end
