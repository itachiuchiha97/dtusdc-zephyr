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
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/divye/dtusdc-zephyr/duda_robot/src/nmea_navsat_driver"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/divye/dtusdc-zephyr/duda_robot/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/divye/dtusdc-zephyr/duda_robot/install/lib/python2.7/dist-packages:/home/divye/dtusdc-zephyr/duda_robot/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/divye/dtusdc-zephyr/duda_robot/build" \
    "/usr/bin/python2" \
    "/home/divye/dtusdc-zephyr/duda_robot/src/nmea_navsat_driver/setup.py" \
    build --build-base "/home/divye/dtusdc-zephyr/duda_robot/build/nmea_navsat_driver" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/divye/dtusdc-zephyr/duda_robot/install" --install-scripts="/home/divye/dtusdc-zephyr/duda_robot/install/bin"
