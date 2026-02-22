execute_process(COMMAND "/home/xzh/Project_gazebo_build/gazebo_build/build/vrx_gazebo/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/xzh/Project_gazebo_build/gazebo_build/build/vrx_gazebo/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
