require "test_helper"

class JSON::Lisp::EnvTest < Minitest::Test
  def test_evaluate
    constants = {
      "a" => 5,
      "b" => 7,
      "+" => -> (a, b) { a + b },
      "-" => -> (a, b) { a - b }
    }

    json_lisp_env = JSON::Lisp::Env.new(constants)

    assert_equal 42, json_lisp_env.evaluate(42)
    assert_equal 5,  json_lisp_env.evaluate("a")
    assert_equal 7,  json_lisp_env.evaluate("b")
    
    assert_equal 12, json_lisp_env.evaluate(["+", "a", "b"])
    assert_equal 2, json_lisp_env.evaluate(["-", "b", "a"])
    assert_equal 3,  json_lisp_env.evaluate(["-", "a", 2])
    assert_equal 9,  json_lisp_env.evaluate(["+", 2, "b"])

    assert_equal 14, json_lisp_env.evaluate(["+", "a", ["+", 2, "b"]])
    assert_equal 10, json_lisp_env.evaluate(["+", "a", ["-", "b", 2]])
  end

  def test_evaluate_json
    constants = {
      "a" => 5,
      "b" => 7,
      "+" => -> (a, b) { a + b }
    }

    json_lisp_env = JSON::Lisp::Env.new(constants)

    assert_equal 42, json_lisp_env.evaluate_json('42')
    assert_equal 5, json_lisp_env.evaluate_json('"a"')
    assert_equal 12, json_lisp_env.evaluate_json('["+", "a", "b"]')
  end
end