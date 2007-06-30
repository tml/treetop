require "#{TREETOP_ROOT}/metagrammar/node_classes"

module Treetop
  Metagrammar = ::Treetop::Grammar.new('Metagrammar')
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:treetop_file), ::Treetop::ZeroOrMore.new(::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:grammar), Metagrammar.nonterminal_symbol(:arbitrary_character)])).with_node_class(MetagrammarNode::TreetopFile)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:arbitrary_character), ::Treetop::AnythingSymbol.new.with_node_class(MetagrammarNode::ArbitraryCharacter)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:grammar), ::Treetop::Sequence.new([::Treetop::TerminalSymbol.new('grammar'), Metagrammar.nonterminal_symbol(:space), Metagrammar.nonterminal_symbol(:grammar_name), Metagrammar.nonterminal_symbol(:parsing_rule_sequence), ::Treetop::Optional.new(Metagrammar.nonterminal_symbol(:space)), ::Treetop::TerminalSymbol.new('end')]).with_node_class(MetagrammarNode::GrammarNode)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:grammar_name), ::Treetop::Sequence.new([::Treetop::Sequence.new([::Treetop::CharacterClass.new('A-Z'), ::Treetop::ZeroOrMore.new(Metagrammar.nonterminal_symbol(:alphanumeric_char))]), Metagrammar.nonterminal_symbol(:space)]).with_node_class(MetagrammarNode::GrammarName)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:parsing_rule_sequence), ::Treetop::OrderedChoice.new([::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:parsing_rule), ::Treetop::ZeroOrMore.new(::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:space), Metagrammar.nonterminal_symbol(:parsing_rule)]))]).with_node_class(MetagrammarNode::ParsingRuleSequence), ::Treetop::TerminalSymbol.new('').with_node_class(MetagrammarNode::Epsilon)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:parsing_rule), ::Treetop::Sequence.new([::Treetop::TerminalSymbol.new('rule'), Metagrammar.nonterminal_symbol(:space), Metagrammar.nonterminal_symbol(:nonterminal), Metagrammar.nonterminal_symbol(:space), Metagrammar.nonterminal_symbol(:parsing_expression), Metagrammar.nonterminal_symbol(:space), ::Treetop::TerminalSymbol.new('end')]).with_node_class(MetagrammarNode::ParsingRuleNode)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:parsing_expression), ::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:choice), Metagrammar.nonterminal_symbol(:sequence), Metagrammar.nonterminal_symbol(:primary)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:instantiator), ::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:sequence), Metagrammar.nonterminal_symbol(:instantiator_primary)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:propagator), ::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:choice), Metagrammar.nonterminal_symbol(:propagator_primary)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:choice), ::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:alternative), ::Treetop::OneOrMore.new(::Treetop::Sequence.new([::Treetop::Optional.new(Metagrammar.nonterminal_symbol(:space)), ::Treetop::TerminalSymbol.new('/'), ::Treetop::Optional.new(Metagrammar.nonterminal_symbol(:space)), Metagrammar.nonterminal_symbol(:alternative)]))]).with_node_class(MetagrammarNode::Choice)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:sequence), ::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:blockless_primary), ::Treetop::OneOrMore.new(::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:space), Metagrammar.nonterminal_symbol(:blockless_primary)])), Metagrammar.nonterminal_symbol(:node_class_expression), Metagrammar.nonterminal_symbol(:trailing_block)]).with_node_class(MetagrammarNode::Sequence)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:alternative), ::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:sequence), Metagrammar.nonterminal_symbol(:primary)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:primary), ::Treetop::OrderedChoice.new([::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:label), Metagrammar.nonterminal_symbol(:labelless_primary)]) {
        def to_ruby(grammar_node)
          "#{labelless_primary.to_ruby(grammar_node)}#{label.to_ruby}"
        end
      }, Metagrammar.nonterminal_symbol(:labelless_primary)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:label), ::Treetop::Sequence.new([::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:alpha_char), ::Treetop::ZeroOrMore.new(Metagrammar.nonterminal_symbol(:alphanumeric_char))]), ::Treetop::TerminalSymbol.new(':')]) {
        def to_ruby
          ".labeled_as(:#{elements[0].text_value})"
        end
      }))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:labelless_primary), ::Treetop::OrderedChoice.new([::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:instantiator_primary), Metagrammar.nonterminal_symbol(:node_class_expression), Metagrammar.nonterminal_symbol(:trailing_block)]).with_node_class(MetagrammarNode::Primary), Metagrammar.nonterminal_symbol(:propagator_primary)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:blockless_primary), ::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:instantiator_primary), Metagrammar.nonterminal_symbol(:propagator_primary)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:instantiator_primary), ::Treetop::OrderedChoice.new([::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:atomic), Metagrammar.nonterminal_symbol(:repetition_suffix)]).with_node_class(MetagrammarNode::InstantiatorPrimary), Metagrammar.nonterminal_symbol(:atomic_instantiator)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:propagator_primary), ::Treetop::OrderedChoice.new([::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:prefix), ::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:instantiator_primary), Metagrammar.nonterminal_symbol(:atomic)])]).with_node_class(MetagrammarNode::PrefixedPrimary), ::Treetop::Sequence.new([::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:instantiator_primary), Metagrammar.nonterminal_symbol(:atomic)]), ::Treetop::TerminalSymbol.new('?')]).with_node_class(MetagrammarNode::OptionalPrimary), Metagrammar.nonterminal_symbol(:atomic_propagator)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:repetition_suffix), ::Treetop::OrderedChoice.new([::Treetop::TerminalSymbol.new('+').with_node_class(MetagrammarNode::Plus), ::Treetop::TerminalSymbol.new('*').with_node_class(MetagrammarNode::Star)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:prefix), ::Treetop::OrderedChoice.new([::Treetop::TerminalSymbol.new('&').with_node_class(MetagrammarNode::And), ::Treetop::TerminalSymbol.new('!').with_node_class(MetagrammarNode::Bang)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:atomic), ::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:atomic_instantiator), Metagrammar.nonterminal_symbol(:atomic_propagator)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:atomic_instantiator), ::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:terminal), Metagrammar.nonterminal_symbol(:parenthesized_instantiator)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:atomic_propagator), ::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:nonterminal), Metagrammar.nonterminal_symbol(:parenthesized_propagator)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:parenthesized_instantiator), ::Treetop::Sequence.new([::Treetop::TerminalSymbol.new('('), ::Treetop::Optional.new(Metagrammar.nonterminal_symbol(:space)), Metagrammar.nonterminal_symbol(:instantiator), ::Treetop::Optional.new(Metagrammar.nonterminal_symbol(:space)), ::Treetop::TerminalSymbol.new(')')]).with_node_class(MetagrammarNode::ParenthesizedInstantiator)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:parenthesized_propagator), ::Treetop::Sequence.new([::Treetop::TerminalSymbol.new('('), ::Treetop::Optional.new(Metagrammar.nonterminal_symbol(:space)), Metagrammar.nonterminal_symbol(:propagator), ::Treetop::Optional.new(Metagrammar.nonterminal_symbol(:space)), ::Treetop::TerminalSymbol.new(')')]).with_node_class(MetagrammarNode::ParenthesizedPropagator)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:nonterminal), ::Treetop::Sequence.new([::Treetop::NotPredicate.new(Metagrammar.nonterminal_symbol(:keyword_inside_grammar)), ::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:alpha_char), ::Treetop::ZeroOrMore.new(Metagrammar.nonterminal_symbol(:alphanumeric_char))])]).with_node_class(MetagrammarNode::Nonterminal)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:terminal), ::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:single_quoted_string), Metagrammar.nonterminal_symbol(:double_quoted_string), Metagrammar.nonterminal_symbol(:character_class), Metagrammar.nonterminal_symbol(:anything_symbol)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:double_quoted_string), ::Treetop::Sequence.new([::Treetop::TerminalSymbol.new('"'), ::Treetop::ZeroOrMore.new(::Treetop::Sequence.new([::Treetop::NotPredicate.new(::Treetop::TerminalSymbol.new('"')), ::Treetop::OrderedChoice.new([::Treetop::TerminalSymbol.new('\"'), ::Treetop::AnythingSymbol.new])])), ::Treetop::TerminalSymbol.new('"')]).with_node_class(MetagrammarNode::DoubleQuotedString)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:single_quoted_string), ::Treetop::Sequence.new([::Treetop::TerminalSymbol.new("'"), ::Treetop::ZeroOrMore.new(::Treetop::Sequence.new([::Treetop::NotPredicate.new(::Treetop::TerminalSymbol.new("'")), ::Treetop::OrderedChoice.new([::Treetop::TerminalSymbol.new("\\'"), ::Treetop::AnythingSymbol.new])])), ::Treetop::TerminalSymbol.new("'")]).with_node_class(MetagrammarNode::SingleQuotedString)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:character_class), ::Treetop::Sequence.new([::Treetop::TerminalSymbol.new('['), ::Treetop::OneOrMore.new(::Treetop::Sequence.new([::Treetop::NotPredicate.new(::Treetop::TerminalSymbol.new(']')), ::Treetop::OrderedChoice.new([::Treetop::TerminalSymbol.new('\]'), ::Treetop::AnythingSymbol.new])])), ::Treetop::TerminalSymbol.new(']')]).with_node_class(MetagrammarNode::CharacterClass)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:anything_symbol), ::Treetop::TerminalSymbol.new('.').with_node_class(MetagrammarNode::AnythingSymbol)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:node_class_expression), ::Treetop::OrderedChoice.new([::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:space), ::Treetop::TerminalSymbol.new('<'), ::Treetop::OneOrMore.new(::Treetop::Sequence.new([::Treetop::NotPredicate.new(::Treetop::TerminalSymbol.new('>')), ::Treetop::AnythingSymbol.new])), ::Treetop::TerminalSymbol.new('>')]).with_node_class(MetagrammarNode::NodeClassExpression), ::Treetop::TerminalSymbol.new('').with_node_class(MetagrammarNode::Epsilon)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:trailing_block), ::Treetop::OrderedChoice.new([::Treetop::Sequence.new([Metagrammar.nonterminal_symbol(:space), Metagrammar.nonterminal_symbol(:block)]).with_node_class(MetagrammarNode::TrailingBlock), ::Treetop::TerminalSymbol.new('').with_node_class(MetagrammarNode::Epsilon)])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:block), ::Treetop::Sequence.new([::Treetop::TerminalSymbol.new('{'), ::Treetop::ZeroOrMore.new(::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:block), ::Treetop::Sequence.new([::Treetop::NotPredicate.new(::Treetop::CharacterClass.new('{}')), ::Treetop::AnythingSymbol.new])])), ::Treetop::TerminalSymbol.new('}')]).with_node_class(MetagrammarNode::Block)))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:keyword_inside_grammar), ::Treetop::Sequence.new([::Treetop::OrderedChoice.new([::Treetop::TerminalSymbol.new('rule'), ::Treetop::TerminalSymbol.new('end')]), ::Treetop::NotPredicate.new(Metagrammar.nonterminal_symbol(:non_space_char))])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:non_space_char), ::Treetop::Sequence.new([::Treetop::NotPredicate.new(Metagrammar.nonterminal_symbol(:space)), ::Treetop::AnythingSymbol.new])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:alpha_char), ::Treetop::CharacterClass.new('A-Za-z_')))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:alphanumeric_char), ::Treetop::OrderedChoice.new([Metagrammar.nonterminal_symbol(:alpha_char), ::Treetop::CharacterClass.new('0-9')])))
Metagrammar.add_parsing_rule(::Treetop::ParsingRule.new(Metagrammar.nonterminal_symbol(:space), ::Treetop::OneOrMore.new(::Treetop::CharacterClass.new(' \t\n\r'))))

end