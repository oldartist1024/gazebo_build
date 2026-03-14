cmake_minimum_required(VERSION 3.0.2)
project(mini_sandisland)

find_package(catkin REQUIRED COMPONENTS
  xacro
)

catkin_package(
  CATKIN_DEPENDS xacro
)

find_program(XACRO_EXE xacro REQUIRED)
file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/generated)

file(GLOB WORLD_XACRO_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} CONFIGURE_DEPENDS
  worlds/*.world.xacro
)

set(GENERATED_WORLD_FILES)
foreach(WORLD_XACRO ${WORLD_XACRO_FILES})
  get_filename_component(WORLD_STEM ${WORLD_XACRO} NAME_WE)
  string(REGEX REPLACE "\\.world$" "" WORLD_NAME ${WORLD_STEM})

  set(WORLD_OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/generated/${WORLD_NAME}.world)
  list(APPEND GENERATED_WORLD_FILES ${WORLD_OUTPUT})

  add_custom_command(
    OUTPUT ${WORLD_OUTPUT}
    COMMAND ${XACRO_EXE}
            ${CMAKE_CURRENT_SOURCE_DIR}/${WORLD_XACRO}
            -o ${WORLD_OUTPUT}
    DEPENDS
      ${CMAKE_CURRENT_SOURCE_DIR}/${WORLD_XACRO}
      ${CMAKE_CURRENT_SOURCE_DIR}/worlds/${WORLD_NAME}.xacro
      ${CMAKE_CURRENT_SOURCE_DIR}/models/ocean_waves/model.xacro
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  )
endforeach()

add_custom_target(generate_worlds ALL
  DEPENDS ${GENERATED_WORLD_FILES}
)

install(DIRECTORY launch config worlds models
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})

install(FILES ${GENERATED_WORLD_FILES}
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/generated)
