# frozen_string_literal: true

require 'parslet'

class RoadmapParser < Parslet::Parser
  rule(:space) { match('\s').repeat(1) }
  rule(:space?) { space.maybe }

  rule(:word) { match('[ -~]').repeat(1) >> space? } # ASCII characters :) 

  rule(:title_text) { word.repeat(0, 10).as(:title) }
  rule(:heading) { match('#').repeat(1) >> space? >> title_text }

  rule(:expression) { heading }

  root(:expression)
end

RoadmapParser.new.parse('#')
