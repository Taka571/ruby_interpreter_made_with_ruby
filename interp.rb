require "minruby"

def evaluate(tree, env)
  case tree[0]
  when "lit"
    tree[1]
  when "+"
    env[:plus_count] += 1
    evaluate(tree[1], env) + evaluate(tree[2], env)
  when "-"
    evaluate(tree[1], env) - evaluate(tree[2], env)
  when "*"
    evaluate(tree[1], env) * evaluate(tree[2], env)
  when "**"
    evaluate(tree[1], env) ** evaluate(tree[2], env)
  when "%"
    evaluate(tree[1], env) % evaluate(tree[2], env)  
  when "/"
    evaluate(tree[1], env) / evaluate(tree[2], env)
  when ">"
    evaluate(tree[1], env) > evaluate(tree[2], env)
  when "<"
    evaluate(tree[1], env) < evaluate(tree[2], env)
  when ">="
    evaluate(tree[1], env) >= evaluate(tree[2], env)
  when "<="
    evaluate(tree[1], env) <= evaluate(tree[2], env)
  when "=="
    evaluate(tree[1], env) == evaluate(tree[2], env)
  when "!="
    evaluate(tree[1], env) != evaluate(tree[2], env)
  when "func_call"
    p(env[:plus_count])
    p(evaluate(tree[2], env))
  when "stmts"
    i = 1
    return_value = nil
    while tree[i] != nil
      return_value = evaluate(tree[i], env)
      i = i + 1
    end
    return_value
  when "var_assign"
    env[tree[1]] = evaluate(tree[2], env)
  when "var_ref"
    env[tree[1]]
  else
    raise "invalid input"
  end
end

# ① 計算式の文字列を読み込む
str = minruby_load()
# ② 計算式の文字列を計算の木に変換する
tree = minruby_parse(str)
# ③ 計算の木を実行（計算）する
env = {}
env[:plus_count] = 0
answer = evaluate(tree, env)
