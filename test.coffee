#!/usr/bin/env coffee

YParser = require "yparser"

parser_json = require "./parser"

bnf = """
id = id ;
int = int ;
space = anyspace+ ;

main :: [space? token]* space? eof
  ;

token ::
    id:id
  | int(toNumber):int
  ;

"""

# generator = new YParser.Generator bnf
# parser = generator.generate()
# console.log JSON.stringify JSON.stringify parser
# process.exit 1

parser = new YParser.GrammarParser
parser.loadJson parser_json

test_str = """
toto titi 42\ttata
tutu 55 hey ho
"""


parser.loadString test_str
parser.init()
parser.parse() or parser.error()
for node in parser.ast.nodes
  console.log JSON.stringify node

