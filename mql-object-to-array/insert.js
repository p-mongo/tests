db.foo.insert([

{
   _id: 1,
   foo: {
      a : { bar: ['cat', 'dog', 'cow'] },
      b : { bar: ['cat', 'cat', 'dog'] },
   }
},
{
   _id: 2,
   foo: {
      c : { bar: ['cow'] },
      d : { bar: ['dog'] },
      e : { bar: ['cow'] },
      f : { bar: ['cat', 'dog', 'cat'] },
   }
},
{
   _id: 3,
   foo: {
      g : { bar: ['cat', 'cow'] },
      h : { bar: ['cow'] },
      i : { bar: ['cat'] },
   }
}
])
