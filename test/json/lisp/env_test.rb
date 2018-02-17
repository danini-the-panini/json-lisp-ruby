require "test_helper"

class JSON::Lisp::EnvTest < Minitest::Test
  def test_evaluate
    constants = {
      "a" => 5,
      "b" => 7,
      "+" => -> (a, b) { a + b }
    }

    json_lisp_env = JSON::Lisp::Env.new(constants)

    assert_equal 12, json_lisp_env.evaluate(["+", "a", "b"])
    assert_equal 8,  json_lisp_env.evaluate(["+", "a", 3])
    assert_equal 9,  json_lisp_env.evaluate(["+", 2, "b"])
    assert_equal 14, json_lisp_env.evaluate(["+", "a", ["+", "b", 2]])
  end
end