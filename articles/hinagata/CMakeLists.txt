project (word-article-template)
cmake_minimum_required (VERSION 2.8)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

set(TEXFILES_PATH ../../texfiles)
set(ARTICLE_NAME main)
set(TEXFILES_PREFIX word)

find_package(LATEX REQUIRED)
find_package(LatexMk REQUIRED)

set(LATEXMK_FLAGS "")
set(TEXFILES ${TEXFILES_PREFIX}.cls)
set(TEXFILES_SRC ${TEXFILES_PREFIX}.dtx)
set(TEXFILES_INS ${TEXFILES_PREFIX}.ins)

add_custom_command(
  OUTPUT ${TEXFILES}
  COMMAND ${CMAKE_COMMAND}
  ARGS .
  CAMMAND ${CMAKE_COMMAND}
  ARGS --build .
  COMMAND cp
  ARGS -r ${TEXFILES_PATH}/${TEXFILES} ${PROJECT_SOURCE_DIR}
  DEPENDS
    ${TEXFILES_PATH}/${TEXFILES_SRC}
    ${TEXFILES_PATH}/${TEXFILES_INS}
)

add_custom_command(
  OUTPUT ${ARTICLE_NAME}.pdf
  COMMAND ${LATEXMK_EXECUTABLE}
  ARGS ${LATEXMK_FLAGS} ${ARTICLE_NAME}.tex
  DEPENDS
    ${ARTICLE_NAME}.tex
    ${TEXFILES}
)

add_custom_target(main ALL echo
  DEPENDS ${ARTICLE_NAME}.pdf
)

add_custom_target(main-clean CLEAN echo
  COMMAND ${LATEXMK_EXECUTABLE}
  ARGS -C
  COMMAND rm
  ARGS -r ${TEXFILES}
)
