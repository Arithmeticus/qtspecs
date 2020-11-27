/* Generated By:JJTree&JavaCC: Do not edit this line. XParserConstants.java */
package org.w3c.xqparser;

public interface XParserConstants {

  int EOF = 0;
  int DirCommentContentDoubleDashError = 176;
  int RbraceError = 177;
  int LeftAngleBracketError = 178;
  int AmpersandError = 179;
  int PITargetError = 180;
  int NumericLiteralError = 181;
  int Slash = 182;
  int SlashSlash = 183;
  int Greatest = 184;
  int Least = 185;
  int External = 186;
  int Lbrace = 187;
  int Rbrace = 188;
  int Ascending = 189;
  int Descending = 190;
  int LeftAngleBracket = 191;
  int Plus = 192;
  int Minus = 193;
  int PragmaOpen = 194;
  int PragmaClose = 195;
  int URIQualifiedStar = 196;
  int NCNameColonStar = 197;
  int StarColonNCName = 198;
  int TagQName = 199;
  int StartTagClose = 200;
  int EmptyTagClose = 201;
  int EndTagOpen = 202;
  int EndTagQName = 203;
  int EndTagClose = 204;
  int ValueIndicator = 205;
  int OpenQuot = 206;
  int CloseQuot = 207;
  int OpenApos = 208;
  int CloseApos = 209;
  int LCurlyBraceEscape = 210;
  int RCurlyBraceEscape = 211;
  int DirCommentStart = 212;
  int DirCommentEnd = 213;
  int DirCommentContentChar = 214;
  int DirCommentContentDashChar = 215;
  int ProcessingInstructionStart = 216;
  int ProcessingInstructionEnd = 217;
  int CdataSectionStart = 218;
  int CdataSectionEnd = 219;
  int StringConstructorStart = 220;
  int StringConstructorEnd = 221;
  int StringConstructorInterpolationStart = 222;
  int StringConstructorInterpolationEnd = 223;
  int IntegerLiteral = 224;
  int DecimalLiteral = 225;
  int DoubleLiteral = 226;
  int StringLiteral = 227;
  int URIQualifiedName = 228;
  int BracedURILiteral = 229;
  int PredefinedEntityRef = 230;
  int EscapeQuot = 231;
  int EscapeApos = 232;
  int ElementContentChar = 233;
  int QuotAttrContentChar = 234;
  int AposAttrContentChar = 235;
  int PITarget = 236;
  int CharRef = 237;
  int QNameToken = 238;
  int NCNameTok = 239;
  int S = 240;
  int Char = 241;
  int Digits = 242;
  int HexDigits = 243;
  int WhitespaceChar = 244;
  int LocalPart = 245;
  int Nmstart = 246;
  int Nmchar = 247;
  int Letter = 248;
  int BaseChar = 249;
  int Ideographic = 250;
  int CombiningChar = 251;
  int Digit = 252;
  int Extender = 253;
  int CommentStart = 254;
  int CommentEnd = 255;
  int CommentContent = 256;
  int ImplicitlyAllowedWhitespace = 257;

  int DEFAULT = 0;
  int XML_COMMENT = 1;
  int QUOT_ATTRIBUTE_CONTENT = 2;
  int APOS_ATTRIBUTE_CONTENT = 3;
  int ELEMENT_CONTENT = 4;
  int PROCESSING_INSTRUCTION = 5;
  int PRAGMA_2 = 6;
  int PRAGMA_3 = 7;
  int START_TAG = 8;
  int END_TAG = 9;
  int PROCESSING_INSTRUCTION_CONTENT = 10;
  int CDATA_SECTION = 11;
  int STRING_CONSTRUCTOR = 12;
  int PRAGMA_1 = 13;
  int EXPR_COMMENT = 14;

  String[] tokenImage = {
    "<EOF>",
    "\"%%%\"",
    "\"xquery\"",
    "\"encoding\"",
    "\"version\"",
    "\"module\"",
    "\"namespace\"",
    "\"=\"",
    "\";\"",
    "\"declare\"",
    "\"boundary-space\"",
    "\"preserve\"",
    "\"strip\"",
    "\"default\"",
    "\"collation\"",
    "\"base-uri\"",
    "\"construction\"",
    "\"ordering\"",
    "\"ordered\"",
    "\"unordered\"",
    "\"order\"",
    "\"empty\"",
    "\"copy-namespaces\"",
    "\",\"",
    "\"no-preserve\"",
    "\"inherit\"",
    "\"no-inherit\"",
    "\"decimal-format\"",
    "\"decimal-separator\"",
    "\"grouping-separator\"",
    "\"infinity\"",
    "\"minus-sign\"",
    "\"NaN\"",
    "\"percent\"",
    "\"per-mille\"",
    "\"zero-digit\"",
    "\"digit\"",
    "\"pattern-separator\"",
    "\"exponent-separator\"",
    "\"import\"",
    "\"schema\"",
    "\"at\"",
    "\"element\"",
    "\"function\"",
    "\"updating\"",
    "\"%\"",
    "\"(\"",
    "\")\"",
    "\"variable\"",
    "\"$\"",
    "\":=\"",
    "\"context\"",
    "\"item\"",
    "\"as\"",
    "\"option\"",
    "\"for\"",
    "\"in\"",
    "\"allowing\"",
    "\"let\"",
    "\"tumbling\"",
    "\"window\"",
    "\"sliding\"",
    "\"start\"",
    "\"when\"",
    "\"only\"",
    "\"end\"",
    "\"previous\"",
    "\"next\"",
    "\"count\"",
    "\"where\"",
    "\"group\"",
    "\"by\"",
    "\"stable\"",
    "\"return\"",
    "\"some\"",
    "\"every\"",
    "\"satisfies\"",
    "\"switch\"",
    "\"case\"",
    "\"typeswitch\"",
    "\"|\"",
    "\"if\"",
    "\"then\"",
    "\"else\"",
    "\"try\"",
    "\"catch\"",
    "\"or\"",
    "\"and\"",
    "\"||\"",
    "\"to\"",
    "\"*\"",
    "\"div\"",
    "\"idiv\"",
    "\"mod\"",
    "\"union\"",
    "\"intersect\"",
    "\"except\"",
    "\"instance\"",
    "\"of\"",
    "\"treat\"",
    "\"castable\"",
    "\"cast\"",
    "\"transform\"",
    "\"with\"",
    "\"=>\"",
    "\"!=\"",
    "\"<=\"",
    "\">\"",
    "\">=\"",
    "\"eq\"",
    "\"ne\"",
    "\"lt\"",
    "\"le\"",
    "\"gt\"",
    "\"ge\"",
    "\"is\"",
    "\"<<\"",
    "\">>\"",
    "\"validate\"",
    "\"type\"",
    "\"lax\"",
    "\"strict\"",
    "\"!\"",
    "\"child\"",
    "\"::\"",
    "\"descendant\"",
    "\"attribute\"",
    "\"self\"",
    "\"descendant-or-self\"",
    "\"following-sibling\"",
    "\"following\"",
    "\"@\"",
    "\"parent\"",
    "\"ancestor\"",
    "\"preceding-sibling\"",
    "\"preceding\"",
    "\"ancestor-or-self\"",
    "\"..\"",
    "\"[\"",
    "\"]\"",
    "\"?\"",
    "\".\"",
    "\"document\"",
    "\"text\"",
    "\"comment\"",
    "\"processing-instruction\"",
    "\"#\"",
    "\"map\"",
    "\":\"",
    "\"array\"",
    "\"empty-sequence\"",
    "\"node\"",
    "\"document-node\"",
    "\"namespace-node\"",
    "\"schema-attribute\"",
    "\"schema-element\"",
    "\"revalidation\"",
    "\"skip\"",
    "\"first\"",
    "\"last\"",
    "\"into\"",
    "\"after\"",
    "\"before\"",
    "\"insert\"",
    "\"nodes\"",
    "\"delete\"",
    "\"replace\"",
    "\"value\"",
    "\"rename\"",
    "\"invoke\"",
    "\"copy\"",
    "\"modify\"",
    "\"block\"",
    "\"exit\"",
    "\"returning\"",
    "\"while\"",
    "<DirCommentContentDoubleDashError>",
    "\"}\"",
    "\"<\"",
    "\"&\"",
    "<PITargetError>",
    "<NumericLiteralError>",
    "\"/\"",
    "\"//\"",
    "\"greatest\"",
    "\"least\"",
    "\"external\"",
    "\"{\"",
    "\"}\"",
    "\"ascending\"",
    "\"descending\"",
    "\"<\"",
    "\"+\"",
    "\"-\"",
    "\"(#\"",
    "\"#)\"",
    "<URIQualifiedStar>",
    "<NCNameColonStar>",
    "<StarColonNCName>",
    "<TagQName>",
    "\">\"",
    "\"/>\"",
    "\"</\"",
    "<EndTagQName>",
    "\">\"",
    "\"=\"",
    "\"\\\"\"",
    "\"\\\"\"",
    "\"\\\'\"",
    "\"\\\'\"",
    "\"{{\"",
    "\"}}\"",
    "\"<!--\"",
    "\"-->\"",
    "<DirCommentContentChar>",
    "<DirCommentContentDashChar>",
    "\"<?\"",
    "\"?>\"",
    "\"<![CDATA[\"",
    "<CdataSectionEnd>",
    "\"``[\"",
    "\"]``\"",
    "\"`{\"",
    "\"}`\"",
    "<IntegerLiteral>",
    "<DecimalLiteral>",
    "<DoubleLiteral>",
    "<StringLiteral>",
    "<URIQualifiedName>",
    "<BracedURILiteral>",
    "<PredefinedEntityRef>",
    "\"\\\"\\\"\"",
    "\"\\\'\\\'\"",
    "<ElementContentChar>",
    "<QuotAttrContentChar>",
    "<AposAttrContentChar>",
    "<PITarget>",
    "<CharRef>",
    "<QNameToken>",
    "<NCNameTok>",
    "<S>",
    "<Char>",
    "<Digits>",
    "<HexDigits>",
    "<WhitespaceChar>",
    "<LocalPart>",
    "<Nmstart>",
    "<Nmchar>",
    "<Letter>",
    "<BaseChar>",
    "<Ideographic>",
    "<CombiningChar>",
    "<Digit>",
    "<Extender>",
    "\"(:\"",
    "\":)\"",
    "<CommentContent>",
    "<ImplicitlyAllowedWhitespace>",
  };

}