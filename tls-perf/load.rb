module TestM
end

def load(load_count)
  load_count.times do |i|
    eval "module TestM#{i}; def f#{i}; true; end; end"
  end

  TestM.module_eval do
    load_count.times do |i|
      eval "include TestM#{i}"
    end
  end

  load_count.times do |i|
    eval "class C#{i}; include TestM; end"
  end
end
