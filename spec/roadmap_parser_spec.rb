# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../roadmap_parser'

describe 'title text' do
  let(:title) { 'This is a title text text blob!' }
  let(:cases) do
    [
      '#',
      '# ',
      '#Title',
      '# Title',
      '#Title Text',
      '# Title Text'
    ]
  end

  it 'parses successfully' do
    cases.each { |c| assert RoadmapParser.new.parse(c) }
  end

  it 'contains the title text after parsing' do
    parsed = RoadmapParser.new.parse("# #{title}")
    assert_equal title, parsed[:title]
  end
end

describe 'timeline axis' do
  let(:cases) do
    [
      '~ |==|',
      '~ |==|',
      '~  |==|'
    ]
  end

  it 'parses successfully' do
    cases.each { |c| assert RoadmapParser.new.parse(c) }
  end
end
