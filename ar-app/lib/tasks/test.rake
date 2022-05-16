task 't:tx' => :environment do
p Rails.env
  puts Post.count
  begin
    Post.transaction do
      Post.create!(title: 'one')
      Post.transaction do
        Post.create!(title: 'two')
      end
      puts "Previous nested transaction succeeded"
      Post.transaction do
        Post.create!(title: 'three')
      end
      puts "All done"
      fail
    end
  rescue => e
    puts "Caught #{e.class}: #{e}"
  end
  puts Post.count
end
