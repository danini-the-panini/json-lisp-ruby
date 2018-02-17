module JSON
  module Lisp
    class Env
      attr_reader :constants

      def initialize(constants)
        @constants = constants.dup.freeze
      end

      def evaluate(expression)
        if expression.is_a?(Array)
          fn = constants[expression[0]]
          params = expression[1..-1].map { |x| evaluate(x) }
          fn[*params]
        elsif expression.is_a?(String)
          constants[expression]
        else
          expression
        end
      end

      def evaluate_json(json_string)
        evaluate(JSON.parse(json_string))
      end
    end
  end
end
