require 'i18n'
require 'mongoid'

I18n.load_path << 'en.yml'

describe Mongoid::Errors::MongoidError do

  let(:error) { described_class.new }
  let(:key) { :callbacks }
  let(:options) { {} }

  before do
    if RUBY_VERSION >= '2.7'
      {"message_title" => "message", "summary_title" => "summary", "resolution_title" => "resolution"}.each do |key, name|
        expect(::I18n).to receive(:translate).with("mongoid.errors.messages.#{key}", **{}).and_return(name)
      end

      ["message", "summary", "resolution"].each do |name|
        expect(::I18n).to receive(:translate).
          with("mongoid.errors.messages.#{key}.#{name}", **{}).
          and_return(name)
      end
    else
      {"message_title" => "message", "summary_title" => "summary", "resolution_title" => "resolution"}.each do |key, name|
        expect(::I18n).to receive(:translate).with("mongoid.errors.messages.#{key}", {}).and_return(name)
      end

      ["message", "summary", "resolution"].each do |name|
        expect(::I18n).to receive(:translate).
          with("mongoid.errors.messages.#{key}.#{name}", {}).
          and_return(name)
      end
    end

    error.compose_message(key, options)
  end

  it 'works' do
  end
end
