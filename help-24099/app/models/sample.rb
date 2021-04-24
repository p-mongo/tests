class Sample

 include Mongoid::Document

 store_in collection: "samples", database: "gig_page"

end
