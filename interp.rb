require "minruby"

def evaluate(tree)
  case tree[0]
  when "lit"
    tree[1]
  when "+"
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left + right
  when "-"
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left - right
  when "*"
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left * right
  when "**"
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left ** right
  when "%"
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left % right  
  when "/"
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left / right
  when ">"
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left > right
  when "<"
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left < right
  when ">="
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left >= right
  when "<="
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left <= right
  when "=="
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left == right
  when "!="
    left  = evaluate(tree[1])
    right = evaluate(tree[2])
    left != right
  when "func_call"
    p(evaluate(tree[2]))
  when "stmts"
    i = 1
    while tree[i] != nil
      evaluate(tree[i])
      i = i + 1
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
answer = evaluate(tree)
