# Cross-compiles a QT for Windows
# Uses MXE with the following dependencies: qttools, boost, db, miniupnpc  
#!/bin/bash
PATH=/usr/lib/mxe/usr/bin:$PATH
MXE_INCLUDE_PATH=/usr/lib/mxe/usr/i686-w64-mingw32.static/include
MXE_LIB_PATH=/usr/lib/mxe/usr/i686-w64-mingw32.static/lib

TARGET_OS=NATIVE_WINDOWS make -C src/leveldb libleveldb.a libmemenv.a CC=i686-w64-mingw32.static-gcc CXX=i686-w64-mingw32.static-g++

i686-w64-mingw32.static-qmake-qt5 \
        BOOST_LIB_SUFFIX=-mt \
        BOOST_THREAD_LIB_SUFFIX=_win32-mt \
        BOOST_INCLUDE_PATH=$MXE_INCLUDE_PATH/boost \
        BOOST_LIB_PATH=$MXE_LIB_PATH \
        OPENSSL_INCLUDE_PATH=$MXE_INCLUDE_PATH/openssl \
        OPENSSL_LIB_PATH=$MXE_LIB_PATH \
        BDB_INCLUDE_PATH=$MXE_INCLUDE_PATH \
        BDB_LIB_PATH=$MXE_LIB_PATH \
        MINIUPNPC_INCLUDE_PATH=$MXE_INCLUDE_PATH \
        MINIUPNPC_LIB_PATH=$MXE_LIB_PATH \
        QMAKE_LRELEASE=/usr/lib/mxe/usr/i686-w64-mingw32.static/qt5/bin/lrelease TrumpCoin-qt.pro

make -f Makefile.Release
