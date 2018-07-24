task 'runme' => :environment do
  puts Post.count
  begin
    Post.transaction do
      Post.create!(title: 'one')
      Post.transaction do
        Post.create!(title: 'one')
      end
      fail
    end
  rescue => e
    puts "Caught #{e}"
  end
  puts Post.count
end
