{-# LANGUAGE ScopedTypeVariables, DoAndIfThenElse, OverloadedStrings #-}
module Main where
import qualified TastierMachine.Machine as Machine
import qualified TastierMachine.Instructions as I
import qualified TastierMachine.Bytecode as Bytecode
import TastierAssembler.Parser
import Data.Array (Array, listArray)
import Data.Int (Int16)
import Data.Char (isSpace, isAlphaNum)
import qualified Data.Binary.Get as G
import qualified Data.Binary.Put as P
import qualified Data.ByteString.Lazy.Char8 as B
import Control.Monad.RWS.Lazy (execRWS)
import System.Environment (getArgs)
import Data.Maybe (fromJust)
import Data.List
import Data.List.Split
import qualified Data.Text as Text
import qualified Data.Map as M
import qualified Control.Monad.RWS.Lazy as RWS

commentOpenString = ";;"
eformatMarker = "."

ignoreLinePredicate l = (not $ B.null l) &&
                        (not $ B.isPrefixOf commentOpenString l) &&
                        (not $ B.isPrefixOf eformatMarker l)

flatten x =
  case x of
    (i, Right a) -> a
    (i, Left b) -> error $ "Line " ++ show i ++
                           ": cannot assemble unresolved instruction " ++ show b

main = do
  args <- getArgs
  if length args == 2 then do
    assemblerFile' <- B.readFile (args !! 0)
	
    let assemblyCopy = B.unpack assemblerFile'          --Convert assembly from ByteString to String
    let assemblyText = Text.pack assemblyCopy           --Convert assembly from String to Text
    let assemblyChunks = Text.splitOn ":" assemblyText  --This separates headers and methods in the assembly file
    let assemblyDecl = head assemblyChunks              --Take only the headers, as the remaining code is procedures
    let instructionArray = Text.lines assemblyDecl      --Split the headers into a list, with each index containing a line
    let declarations = init instructionArray            --Drop the procedure declaration at the tail of the list
    let temp = intersperse " " declarations             --Put spaces at the end of each line before removing all line breaks
    let formatted = Text.unlines temp                   --remove line breaks since they cannot be parsed by tastier virtual machine
    let completedIns = Text.unpack formatted            --Convert from text back to string
    
    putStrLn completedIns                               --print headers to standard output

    let preamble = B.pack completedIns                  --convert headers to ByteString, then save at beginning of assemblerFile.

    let assemblerFile = preamble `B.append` "Call 0 Main\nJmp $END\n" `B.append` assemblerFile'
                        `B.append` "\n$END: Halt\n"

    

    let chunks = filter ignoreLinePredicate $
                 map (B.dropWhile isSpace) $
                 B.lines assemblerFile

    let ((lines, insts, symtab), instructions) = RWS.execRWS
                                                 parse
                                                 chunks
                                                 (1, 0, M.empty)

    let instructions' = patchLabelAddresses symtab
                        (zip [1..length instructions] instructions)

    let instructions'' = map flatten instructions'

    B.writeFile (args !! 1) $ P.runPut $ Bytecode.save instructions''
  else
    error $ "Usage: tasm <input assembler file> <output bytecode file>"
