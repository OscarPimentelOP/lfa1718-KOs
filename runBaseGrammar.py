import subprocess
import os.path
import sys

def main():
    if(len(sys.argv)-1 == 0):
        compileAntlr()
        compileJava()
        exit()
    else:
        filepath = sys.argv[1]
        if(os.path.isfile(filepath)):
            compileAntlr()
            compileJava()
            exeJava(filepath)
            cleanAntlr()
            exit()
        else:
            print("USAGE: python3 runBaseGrammar [filepath]")
            exit()


def compileAntlr():
    subprocess.Popen(["antlr4","-visitor","BaseGrammar.g4"]).wait()

def compileJava():
    subprocess.Popen("javac BaseGrammar*.java",shell=True).wait()

def exeJava(filepath):
    subprocess.Popen(["java","BaseGrammarMain",filepath]).wait()

def cleanAntlr():
    subprocess.Popen(["antlr4-clean"],stdout=subprocess.DEVNULL).wait()

main()