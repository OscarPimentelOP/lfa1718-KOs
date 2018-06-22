import static java.lang.System.*;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.TerminalNode;




public class BaseGrammarSemanticCheck extends BaseGrammarBaseVisitor<Boolean> {


    /*
    @Override public Boolean visitCheckVar(BaseGrammarParser.CheckVarContext ctx){

    @Override public Boolean visitCommand(BaseGrammarParser.CommandContext ctx){

        Boolean res = true;
        String name = ctx.NAME().getText();
        if (!BaseGrammarParser.symbolTable.containsKey(name)){
            ErrorHandling.printError(ctx, "Variable \""+name+"\" does not exist!");
            res = false;
        }
        return res;
    }
    */

    //verificar se é simple var ou unit var
    //simVar i = 2kg -> erro
    @Override public Boolean visitAssignment(BaseGrammarParser.AssignmentContext ctx){
        Boolean res = true;
        String id = ctx.NAME().getText();


        if (!BaseGrammarParser.symbolTable.containsKey(id)){
            ErrorHandling.printError(ctx, "Variable \"" + name + "\" is not declared!");
            res = false;
        }
        else{
            if(ctx.varType().getText().equals("simpVar")){
                String abc = "ola";

            }
            else {
                String abc = "ola";

            }



        }
        return res;

    }


    /*


    @Override public Boolean visitDecrement(BaseGrammarParser.DecrementContext ctx){     
        Boolean res = true;
        String name = ctx.NAME().getText();
        if (!BaseGrammarParser.symbolTable.containsKey(name)){
            ErrorHandling.printError(ctx, "Variable \""+name+"\" does not exist!");
            res = false;
        }
        return res;
    }

    @Override public Boolean visitIncrement(BaseGrammarParser.IncrementContext ctx){     
        Boolean res = true;
        String name = ctx.NAME().getText();

        if (!BaseGrammarParser.symbolTable.containsKey(name)){
            ErrorHandling.printError(ctx, "Variable \""+name+"\" does not exist!");
            res = false;
        }
        return res;
    }
    */

    /*
    @Override public Boolean visitSimple(BaseGrammarParser.AssignVarContext ctx){
        Boolean res = true;

        String id = ctx.STRING().getText();

        BGSymbol s = BaseGrammarParser.symbolTable.get(id);


        if(s.type != vartype.simpVar){
            ErrorHandling.printError(ctx, "Variable \"" + id + "\" should be Simple!");
            res = false;

        }
        return res;
    }
    */
    @Override
    public Boolean visitVarDec(BaseGrammarParser.VarDecContext ctx) {
        Boolean res = true;
        String id = ctx.NAME().getText();
        if (BaseGrammarParser.symbolTable.containsKey(id)) {
            ErrorHandling.printError(ctx, "Variable \"" + id + "\" already declared!");
            res = false;
        } else {
            if (ctx.varType().getText().equals("simpVar")) {
                BaseGrammarParser.symbolTable.put(id, new BaseGrammarSymbol(id, vartype.simpVar));
            } else
                BaseGrammarParser.symbolTable.put(id, new BaseGrammarSymbol(id, vartype.unitVar));
        }
        return res;
    }

    @Override
   // public Boolean visitAssignVar(BaseGrammarParser.AssignVarContext ctx) {

    //}

    public Boolean visitOp(BaseGrammarParser.OpContext ctx) {
        Boolean res = true;


        return res;

    }


}


