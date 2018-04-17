# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../roadmap_parser'

describe 'title' do
  let(:title) { '#this is a test title'}
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

  it 'is useful' do
    parsed = RoadmapParser.new.parse('# This is a title text text blob!')
    pp parsed
  end
end
