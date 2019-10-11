require_relative './tester'

class ClientTester < Tester
  def perform_operation
    collection.find(a: 1).to_a
  end
end
