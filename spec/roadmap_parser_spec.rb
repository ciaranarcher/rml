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
  describe 'parsing a single segment' do
    let(:input) do
      '~   |====s1=====|==s2=|'
    end

    it 'parses successfully' do
      results = RoadmapParser.new.parse(input)
      assert_equal 2, results[:axis_sections].length

      first_section = results[:axis_sections].first[:axis_section]
      assert_equal 's1', first_section[:title]
      assert_equal 4, first_section[:spacers_pre].length
      assert_equal 5, first_section[:spacers_post].length

      second_section = results[:axis_sections].last[:axis_section]
      assert_equal 's2', second_section[:title]
      assert_equal 2, second_section[:spacers_pre].length
      assert_equal 1, second_section[:spacers_post].length
    end
  end
end
