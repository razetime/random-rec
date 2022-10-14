{-# OPTIONS_GHC -Wno-tabs #-}

{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE StandaloneDeriving #-}

module Parser where

import Data.Char
import Control.Applicative
--import Control.Monad
--import Control.Monad.Reader
import Control.Monad.Except
import Control.Monad.State


raise :: String -> Either Error a
raise = throwError

newtype Parser a = MakeParser (String -> Maybe (a, String))
	deriving Functor

instance Monad Parser where
	return x = MakeParser $ \ s -> Just (x, s)
	p >>= f = MakeParser $ \ s ->
		case runParser p s of
			Just (x, s') -> runParser (f x) s'
			Nothing -> Nothing

instance Applicative Parser where
	pure = return
	mf <*> mx = do
		f <- mf
		x <- mx
		return $ f x

instance Alternative Parser where
	empty = MakeParser $ \ s -> Nothing
	p <|> q = MakeParser $ \ s ->
		case runParser p s of
			Nothing -> runParser q s
			Just x -> Just x

data Sexp
	= AtomL String
	| IntL Integer
	| BoolL Bool
--	| FuncL (MyState -> Either Error MyState)
	| FuncL (MyState -> ExceptT Error (State Table) MyState)
	| MacroL (MyState -> ExceptT Error (State Table) MyState)
	| Sexp := Sexp
	| NilL
--	| ErrorL String

infixr 5 :=

type Table = [(String, Sexp)]
type MyState = (Table, Sexp)

type Error = String

{-instance Show Sexp where
	show = \case
		AtomL x -> "A\"" ++ x ++ "\""
		IntL x -> "I<" ++ show x ++ ">"
		BoolL x -> case x of
			True -> "<#t>"
			False -> "<#f>"
		FuncL x -> "<F>"
		(x := y) -> "(" ++ show x ++ " " ++ show y ++ ")"
		NilL -> "()"
		ErrorL s -> s-}

instance Show Sexp where
	show = \case
		AtomL x -> "AtomL " ++ show x
		IntL x -> "IntL " ++ show x
		BoolL x -> "BoolL " ++ show x
		FuncL _ -> "<F>"
		MacroL _ -> "<M>"
		(x := y) -> "(" ++ show x ++ " := " ++ show y ++ ")"
		NilL -> "NilL"
--		ErrorL s -> "ErrorL " ++ s

instance Eq (MyState -> ExceptT Error (State Table) MyState) where _ == _ = False
instance Eq (Sexp -> ExceptT Error (State Table) MyState) where _ == _ = False
deriving instance Eq Sexp

runParser :: Parser a -> String -> Maybe (a, String)
runParser (MakeParser f) = f




-- always fails
failP :: Parser a
failP = MakeParser $ \s -> Nothing

-- always passes, consuming 1 character
passP :: Parser Char
passP = MakeParser $ \case
	c : cs -> Just (c, cs)
	_ -> Nothing

-- consumes a character that passes a predicate, p
satisfy :: (Char -> Bool) -> Parser Char
satisfy p = MakeParser $ \case
	c : cs | p c -> Just (c, cs)
	_ -> Nothing

-- parses a specific character, c
charP :: Char -> Parser Char
charP c = satisfy (== c)

-- consumes all whitespace characters
spaceP :: Parser String
spaceP = many $ satisfy isSpace

-- parses a string of allowed characters
wordP :: Parser String
wordP = do
	spaceP
	some (satisfy $ flip elem chars) where
		chars = ['a' .. 'z'] ++ ['A' .. 'Z'] ++ ['0' .. '9'] ++ ['+', '-', '*', '/', '=', '#']

-- parses a string in which all characters meet a predicate
wordP' :: (Char -> Bool) -> Parser String
wordP' p = do
	some $ satisfy p

-- parses any alphabetic string
lettersP :: Parser String
lettersP = some $ satisfy isAlpha

-- parses a given string
stringP :: String -> Parser String
stringP = \case
	[] -> return []
	x : xs -> do
		c <- charP x
		cs <- stringP xs
		return $ c : cs

-- parses an (AtomL s)
atomP :: Parser Sexp
atomP = do
	s <- wordP
	return (AtomL s)

-- parses an integer
numP :: Parser Integer
numP = do
	ns <- some $ satisfy isDigit
	return $ read ns

-- parses an (IntL i)
intP :: Parser Sexp
intP = do
	spaceP
	i <- numP
	return $ IntL i

-- parses a parenthesized string
parensP :: Parser a -> Parser a
parensP p = do
	spaceP
	charP '('
	spaceP
	result <- p
	spaceP
	charP ')'
	return result

-- parses a cons expression
consP :: Parser Sexp
consP = do
 cells <- parensP $ many sexpP
 return $ foldr (:=) NilL cells

-- confirms complete parse
finishedP :: Maybe (a, String) -> Maybe a
finishedP = \case
	Just (a, "") -> Just a
	_ -> Nothing

-- parses an s expression
sexpP :: Parser Sexp
sexpP = consP <|> intP <|> atomP

-- deals with potential parse failure
unwrap :: Maybe Sexp -> Either Error Sexp
unwrap = \case
	Nothing -> raise "Parse Failure"
	Just x -> return x

parse :: String -> Either Error Sexp
parse = unwrap . finishedP . runParser sexpP
