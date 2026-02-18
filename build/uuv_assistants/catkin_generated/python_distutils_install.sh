#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/xzh/gazebo_build/src/uuv_assistants"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/xzh/gazebo_build/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/xzh/gazebo_build/install/lib/python3/dist-packages:/home/xzh/gazebo_build/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/xzh/gazebo_build/build" \
    "/usr/bin/python3" \
    "/home/xzh/gazebo_build/src/uuv_assistants/setup.py" \
     \
    build --build-base "/home/xzh/gazebo_build/build/uuv_assistants" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/xzh/gazebo_build/install" --install-scripts="/home/xzh/gazebo_build/install/bin"
