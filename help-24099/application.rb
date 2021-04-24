require 'rubygems'

require 'bundler'

Bundler.require(:default)

Mongoid.load!("config/mongoid.yml")

Dir["#{File.dirname(__FILE__)}/app/models/**/*.rb"].each { |f| require f }



# return :secondary n% of the time (where n = secondary_percentage)

def get_read_preference(secondary_percentage)

 (secondary_percentage >= rand(1..100)) ? :secondary : :primary

end



module API

 class Root < Grape::API

   format :json

   prefix :api



   get :sample do

     read_pref = get_read_preference(params["secondaryRedirectionPercentage"].to_i || 0)

     doc = nil

     trace = []

     StatsD.increment("atlas.samples.counter")

     StatsD.measure("atlas.samples.#{read_pref}") do

       #tp = TracePoint.new(:call) do |x|

       #  trace << "#{x.defined_class}##{x.method_id.to_s} @ #{x.path}"

       #end

       #tp.enable

       doc = Sample.collection.aggregate([{ :'$sample' => { size: 1 } }], read: { mode: read_pref }).first

     #ensure

       #tp.disable

     end

     error! "Not Found", 404 unless doc

     { pref: read_pref, trace: trace, doc: doc.as_json }

   end

 end

end



# Mounting the Grape application

Application = Rack::Builder.new do

 map "/" do

   run API::Root

 end

end
