require "minruby"

def evaluate(tree, genv, lenv)
  case tree[0]
  when "lit"
    tree[1]
  when "+"
    lenv[:plus_count] += 1
    evaluate(tree[1], genv, lenv) + evaluate(tree[2], genv, lenv)
  when "-"
    evaluate(tree[1], genv, lenv) - evaluate(tree[2], genv, lenv)
  when "*"
    evaluate(tree[1], genv, lenv) * evaluate(tree[2], genv, lenv)
  when "**"
    evaluate(tree[1], genv, lenv) ** evaluate(tree[2], genv, lenv)
  when "%"
    evaluate(tree[1], genv, lenv) % evaluate(tree[2], genv, lenv)  
  when "/"
    evaluate(tree[1], genv, lenv) / evaluate(tree[2], genv, lenv)
  when ">"
    evaluate(tree[1], genv, lenv) > evaluate(tree[2], genv, lenv)
  when "<"
    evaluate(tree[1], genv, lenv) < evaluate(tree[2], genv, lenv)
  when ">="
    evaluate(tree[1], genv, lenv) >= evaluate(tree[2], genv, lenv)
  when "<="
    evaluate(tree[1], genv, lenv) <= evaluate(tree[2], genv, lenv)
  when "=="
    evaluate(tree[1], genv, lenv) == evaluate(tree[2], genv, lenv)
  when "!="
    evaluate(tree[1], genv, lenv) != evaluate(tree[2], genv, lenv)
  when "func_call"
    p(lenv[:plus_count])
    p(evaluate(tree[2], genv, lenv))
  when "stmts"
    i = 1
    return_value = nil
    while tree[i] != nil
      return_value = evaluate(tree[i], genv, lenv)
      i = i + 1
    end
    return_value
  when "var_assign"
    lenv[tree[1]] = evaluate(tree[2], genv, lenv)
  when "var_ref"
    lenv[tree[1]]
  when "if"
    if evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    else
      evaluate(tree[3], genv, lenv)
    end
  when "while"
    while evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    end
  else
    raise "invalid input"
  end
end

# ① 計算式の文字列を読み込む
str = minruby_load()
# ② 計算式の文字列を計算の木に変換する
tree = minruby_parse(str)
# ③ 計算の木を実行（計算）する
genv = { "p" => ["builtin", "p"] }
lenv = {}
lenv[:plus_count] = 0
answer = evaluate(tree, genv, lenv)
