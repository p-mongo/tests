namespace :t do
  task types: :environment do
    TypeTest.delete_all
    TypeTest.create!(str: 2)
    p TypeTest.last
    TypeTest.create!(dec: 'x')
    p TypeTest.last
    TypeTest.create!(t: 42)
    p TypeTest.last
    TypeTest.create!(t: 'x')
    p TypeTest.last
    TypeTest.create!(ts: 42)
    p TypeTest.last
    TypeTest.create!(ts: 'x')
    p TypeTest.last

    #TypeTest.create!(hs: 42)
    #p TypeTest.last

    #TypeTest.create!(hs: 'x')
    #p TypeTest.last

    #TypeTest.create!(a: 42)
    #p TypeTest.last
    #TypeTest.create!(a: 'x')
    #p TypeTest.last
    #TypeTest.create!(i: 42)
    #p TypeTest.last
    #TypeTest.create!(i: 'x')
    #p TypeTest.last
  end

=begin
serene2% rake t:types
#<TypeTest id: 14, str: "2", dec: nil, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:19.822179000 +0000", updated_at: "2022-05-21 02:28:19.822179000 +0000">
#<TypeTest id: 15, str: nil, dec: 0.0, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:19.827889000 +0000", updated_at: "2022-05-21 02:28:19.827889000 +0000">
#<TypeTest id: 16, str: nil, dec: nil, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:19.831150000 +0000", updated_at: "2022-05-21 02:28:19.831150000 +0000">
#<TypeTest id: 17, str: nil, dec: nil, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:19.834031000 +0000", updated_at: "2022-05-21 02:28:19.834031000 +0000">
#<TypeTest id: 18, str: nil, dec: nil, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:19.837852000 +0000", updated_at: "2022-05-21 02:28:19.837852000 +0000">
#<TypeTest id: 19, str: nil, dec: nil, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:19.841051000 +0000", updated_at: "2022-05-21 02:28:19.841051000 +0000">
rake aborted!
ActiveRecord::StatementInvalid: PG::InvalidTextRepresentation: ERROR:  malformed array literal: "42"
DETAIL:  Array value must start with "{" or dimension information.
CONTEXT:  unnamed portal parameter $6 = '...'
/home/w/apps/tests/pg-app/lib/tasks/test.rake:20:in `block (2 levels) in <top (required)>'

Caused by:
PG::InvalidTextRepresentation: ERROR:  malformed array literal: "42"
DETAIL:  Array value must start with "{" or dimension information.
CONTEXT:  unnamed portal parameter $6 = '...'
/home/w/apps/tests/pg-app/lib/tasks/test.rake:20:in `block (2 levels) in <top (required)>'
Tasks: TOP => t:types
(See full trace by running task with --trace)
serene2% rake t:types
#<TypeTest id: 20, str: "2", dec: nil, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:28.089074000 +0000", updated_at: "2022-05-21 02:28:28.089074000 +0000">
#<TypeTest id: 21, str: nil, dec: 0.0, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:28.094781000 +0000", updated_at: "2022-05-21 02:28:28.094781000 +0000">
#<TypeTest id: 22, str: nil, dec: nil, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:28.098065000 +0000", updated_at: "2022-05-21 02:28:28.098065000 +0000">
#<TypeTest id: 23, str: nil, dec: nil, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:28.101077000 +0000", updated_at: "2022-05-21 02:28:28.101077000 +0000">
#<TypeTest id: 24, str: nil, dec: nil, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:28.104242000 +0000", updated_at: "2022-05-21 02:28:28.104242000 +0000">
#<TypeTest id: 25, str: nil, dec: nil, t: nil, ts: nil, hs: nil, a: nil, i: nil, created_at: "2022-05-21 02:28:28.107142000 +0000", updated_at: "2022-05-21 02:28:28.107142000 +0000">
rake aborted!
ActiveRecord::StatementInvalid: PG::InvalidTextRepresentation: ERROR:  invalid input syntax for type inet: "42"
CONTEXT:  unnamed portal parameter $7 = '...'
/home/w/apps/tests/pg-app/lib/tasks/test.rake:27:in `block (2 levels) in <top (required)>'

Caused by:
PG::InvalidTextRepresentation: ERROR:  invalid input syntax for type inet: "42"
CONTEXT:  unnamed portal parameter $7 = '...'
/home/w/apps/tests/pg-app/lib/tasks/test.rake:27:in `block (2 levels) in <top (required)>'
Tasks: TOP => t:types
(See full trace by running task with --trace)
=end

end
