require "benchmark"

TEST = 100
comment = Comment.last

Benchmark.bmbm do |b|
  b.report "memoize ||=" do
    TEST.times { @mentions ||= comment.content.scan(/@([a-z0-9_]+)/i).flatten }
  end
  
  b.report "assign =" do
    TEST.times { @mentions = comment.content.scan(/@([a-z0-9_]+)/i).flatten }
  end
  
  b.report "no assign" do
    TEST.times { comment.content.scan(/@([a-z0-9_]+)/i).flatten }
  end
end