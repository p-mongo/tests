task :seed => :environment do
  root=Folder.new(name:'/')

  %w(ex aut dolorem et etc).each do |name|
    root.child_folders<<Folder.new(name: name)
  end

  root.child_folders.first.child_folders << Folder.new(name: 'sub')

  root.save!
end

task :repro => :environment do

  root = Folder.where(name: '/').first

  p Folder.elem_match(child_folders: {name: 'dolorem'}).to_a
  p root.child_folders.elem_match(child_folders: {name: 'sub'}).to_a

end
