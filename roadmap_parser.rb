# frozen_string_literal: true

require 'parslet'

class RoadmapParser < Parslet::Parser
  MAX_TITLE_LEN = 100
  MAX_AXIS_SPACERS = 100
  MAX_AXIS_SECTIONS = 100

  rule(:space) { match('\s').repeat(1) }
  rule(:space?) { space.maybe }

  rule(:word) { match('[ -~]').repeat(1) >> space? } # ASCII characters

  # Title
  rule(:title_text) { word.repeat(0, MAX_TITLE_LEN).as(:title) }
  rule(:heading) { match('#').repeat(1) >> space? >> title_text }

  # Axis row
  rule(:axis) do
    axis_start >>
      space? >> axis_section.repeat(0, MAX_AXIS_SECTIONS) >> 
      axis_section_marker
  end

  rule(:axis_start) { match('~').repeat(1) }
  rule(:axis_section_marker) { match('\|').repeat(1) }
  rule(:axis_spacers) { match('=').repeat(1, MAX_AXIS_SPACERS) }
  rule(:axis_section) { axis_section_marker >> axis_spacers }

  rule(:expression) { heading | axis }

  root(:expression)
end

RoadmapParser.new.parse('#')
