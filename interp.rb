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
  when "func_def"
    genv[tree[1]] = ["user_defined", tree[2], tree[3]]
  when "func_call"
    p(lenv[:plus_count])
    args = []
    i = 0
    while tree[i + 2]
      args[i] = evaluate(tree[i + 2], genv, lenv)
      i = i + 1
    end
    mhd = genv[tree[1]]
    if mhd[0] == "builtin"
      minruby_call(mhd[1], args)
    else
      params = mhd[1]
      i = 0
      while params[i]
        lenv[params[i]] = args[i]
        i = i + 1
      end
      evaluate(mhd[2], genv, lenv)
    end
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
