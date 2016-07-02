AC_PREREQ([2.69])
AC_INIT(article-template, 1.0, word@coins.tsukuba.ac.jp)

AC_CHECK_PROG(PLATEX, platex, platex)
AC_CHECK_PROG(LUALATEX, lualatex, lualatex)

AC_ARG_ENABLE([luatex],
  AS_HELP_STRING([--enable-luatex],
    [enable the use of luatex]),
  [ENABLE_LUATEX=true],
  [ENABLE_LUATEX=false]
)

if test "$ENABLE_LUATEX" = "true" && test -z "$LUALATEX"; then
  AC_MSG_ERROR([Unable to use LuaLaTeX])
fi

if test "$ENABLE_LUATEX" = "false" && test -z "$PLATEX"; then
  AC_MSG_ERROR([Unable to use pLaTeX])
fi

if test "$ENABLE_LUATEX" = "true"; then
  SRC=main-lua
	CLASS=word-lua
	TEXDEPS=word-lua.cls
	PDFFLAG=-pdf
else
  SRC=main-ptex
	CLASS=word
	TEXDEPS="word.cls word.clo"
fi

AC_SUBST(SRC)
AC_SUBST(CLASS)
AC_SUBST(TEXDEPS)
AC_SUBST(PDFFLAG)

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
