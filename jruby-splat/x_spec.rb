require 'i18n'

I18n.load_path << 'en.yml'

p RUBY_VERSION

describe 'splats' do
  it 'ruby 2.7' do
    expect(I18n).to receive(:translate).with('foo', **{})
    I18n.translate('foo', **{})
  end

  it 'ruby 2.6' do
    expect(I18n).to receive(:translate).with('foo', {})
    I18n.translate('foo', {})
  end
end
