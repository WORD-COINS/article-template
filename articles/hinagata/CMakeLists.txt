project (word-article-template)
cmake_minimum_required (VERSION 2.8)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

set(TEXFILES_PATH ../../texfiles)
set(ARTICLE_NAME main)
set(TEXFILES_PREFIX word)

find_package(LATEX REQUIRED)
find_package(LatexMk REQUIRED)

option(ENABLE_LUATEX "enalbe the use of luatex" OFF)
if(ENABLE_LUATEX)
  set(PAPER_NAME ${ARTICLE_NAME}-lua)
  set(LATEXMK_FLAGS "-pdf")
  set(TEXFILES ${TEXFILES_PREFIX}-lua.cls)
  set(TEXFILES_SRC ${TEXFILES_PREFIX}-lua.dtx)
else()
  set(PAPER_NAME ${ARTICLE_NAME}-ptex)
  set(LATEXMK_FLAGS "")
  set(TEXFILES ${TEXFILES_PREFIX}.clo ${TEXFILES_PREFIX}.cls)
  set(TEXFILES_SRC ${TEXFILES_PREFIX}.dtx)
endif()

foreach(f ${TEXFILES})
  add_custom_command(
    OUTPUT ${f}
    COMMAND make
    ARGS ${TEXFILES} -C ${TEXFILES_PATH}
    COMMAND cp
    ARGS -r ${TEXFILES_PATH}/${f} ${PROJECT_SOURCE_DIR}
    DEPENDS
      ${TEXFILES_PATH}/${TEXFILES_SRC}
  )
endforeach()

add_custom_command(
  OUTPUT ${PAPER_NAME}.pdf
  COMMAND ${LATEXMK_EXECUTABLE}
  ARGS ${LATEXMK_FLAGS} ${PAPER_NAME}.tex
  DEPENDS
    ${PAPER_NAME}.tex
    ${ARTICLE_NAME}.tex
    ${TEXFILES}
)

add_custom_command(
  OUTPUT ${ARTICLE_NAME}.pdf
  COMMAND mv
  ARGS ${PAPER_NAME}.pdf ${ARTICLE_NAME}.pdf
  DEPENDS
    ${PAPER_NAME}.pdf
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
