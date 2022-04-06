task em: :environment do
  Band.destroy_all
  Band.create!(name: 'foo',
    cities: [
      City.new(name: 'foo city', founded: 1949),
      City.new(name: 'bar city', founded: 1950),
    ],
  )
  Band.create!(name: 'foo1',
    cities: [
      City.new(name: 'foo city', founded: 1949),
    ],
  )
  Band.create!(name: 'foo2',
    cities: [
      City.new(name: 'foo city', founded: 1949),
      City.new(name: 'bar city', founded: 1940),
    ],
  )

  scope = Band.where(cities: {'$elemMatch' =>
    {'$or' => [
      {founded: {'$gt' => 1949}},
      {name: 'bar city'},
    ]}})
  p scope
  p scope.to_a
end
