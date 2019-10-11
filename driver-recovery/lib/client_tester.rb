require_relative './tester'

class ClientTester < Tester
  def perform_operation
    collection.find(a: Time.now.to_f.to_s).to_a
  end
end
