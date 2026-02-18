execute_process(COMMAND "/home/xzh/gazebo_build/build/uuv_assistants/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/xzh/gazebo_build/build/uuv_assistants/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
