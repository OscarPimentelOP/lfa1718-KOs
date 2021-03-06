grammar BaseGrammar;
import BaseLexerRules;
@parser::header {
import java.util.Map;
import java.util.HashMap;
}

@parser::members {static protected Map<String,BGSymbol> symbolTable = new HashMap<>();
}

// Instructions may or may not be separated by '\n' character
// Accepts empty lines
main: statList EOF;

statList: (stat)*;

stat:
    loop
    |if_else
    |instruction
    ;

// Value

value returns[vartype typ,String unit,String nr]:
    num=(INT|REAL) pow? NAME            #valueUnit
    | '!' num=(INT|REAL) pow? NAME      #valueUnitNeg
    |num=(INT|REAL) pow?                #valueS
    | '!' num=(INT|REAL) pow?           #valueSNeg
    ;

// General intruction
instruction returns[String varName]:
    // Variable declaration
    varType NAME                                        #varDec
    // Print/Read variable
    | print                                             #instPrint
    // Value atribution to variable
    // (This also accepts values that are not the result of an operation)
    |(varType)? NAME '=' operation                                #assignment
    // Operation without storing result or (most common) variable increment/decrement
    | operation                                         #soloOp
    | deincrement                                       #instDeincr
    | convValue                                         #instConv
    ;

print: 'Print' '(' NAME ')';

/* --------------------
 * CONDITIONALS SECTION
 * --------------------
 */
if_else:
    'if' '(' (cc=condition|bc=booleanCondition) ')' (ifA=ifArg) ('else' (elseA=ifArg))?;

ifArg:
    '{'statList'}'      #ifStatList
    |stat?              #ifStat
    ;

/* -------------
 * LOOPS SECTION
 * -------------
 */
loop:
    // FOR LOOP
    'for' '(' var=NAME ';' min=INT ';' max=INT ')' '{' statList '}'                                       #loopFor
    // WHILE LOOP
    | 'while' '(' (cc=condition|bc=booleanCondition) ')' '{' statList '}'                                 #loopWhile
    // DO-WHILE LOOP
    | 'do' '{' statList '}' 'while' '(' (cc=condition|bc=booleanCondition) ')'                            #loopDoWhile
    ;

/* ------------------
 * OPERATIONS SECTION
 * ------------------
 */
// Operations
operation returns [vartype ty,String varGen] :
    '(' n=operation ')'                                     #par
    | left=operation NUMERIC_OPERATOR right=operation       #op
    | NAME                                                  #assignVar
    | value                                                 #val
    ;

deincrement returns [vartype ty]:
          NAME '++'                                             #increment
        | NAME '--'                                             #decrement
        ;

// Conditions
booleanCondition returns[String varGen]:
    left=booleanCondition BOOLEAN_OPERATOR right=booleanCondition   #boolCondOp
    |NOT condition                                                  #boolNotCond
    |condition                                                      #boolCond
    ;

condition returns[String varGen]:
    left=conditionE CONDITIONAL_OPERATOR right=conditionE              #compare
    |conditionE                                                        #soloCond
    ;

conditionE returns [vartype type,String varGen]:
    value           #condiEValue
    |NAME           #condiEVar
    ;


convValue: src=value '€' dest=NAME;

// Variable Types
varType:
    'simpVar'   #simple
    | 'unitVar' #unit
    ;

// Equivalent to "*10^"
pow: 'e^' (min='!')? exp=(INT|REAL);

BOOLEAN_OPERATOR:
    'and'
    | 'or'
    ;
NOT: 'not';

NAME: [a-zA-Z] [a-zA-Z_0-9]*;
WS: [ \t\r\n]+ -> skip;
COMMENT: '->' ~[\r\n]* -> skip;
