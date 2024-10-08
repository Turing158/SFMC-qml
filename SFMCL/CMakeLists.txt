cmake_minimum_required(VERSION 3.21.1)

option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(SFMCLApp LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Core Gui Qml Quick)


if (Qt6_VERSION VERSION_GREATER_EQUAL 6.3)
    qt_standard_project_setup()
endif()

qt_add_executable(SFMCLApp src/main.cpp
    res.qrc
    src/launcher.h src/launcher.cpp
    src/entity/player.h src/entity/player.cpp
    src/entity/lib.h src/entity/lib.cpp
    src/entity/download.h src/entity/download.cpp
    src/util/stdutil.h src/util/stdutil.cpp
    src/util/launcherutil.h src/util/launcherutil.cpp
    src/util/networkutil.h src/util/networkutil.cpp
    src/util/loginutil.h src/util/loginutil.cpp
    src/util/filedirutil.h src/util/filedirutil.cpp
    src/util/downloadutil.h src/util/downloadutil.cpp
    src/entity/downloader.h src/entity/downloader.cpp



)

include_directories(lib/jsoncpp/include)
add_subdirectory(lib/jsoncpp)


qt_add_resources(SFMCLApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)
target_link_libraries(SFMCLApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    jsoncpp_lib
)

set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)
set(QML_IMPORT_PATH ${QT_QML_OUTPUT_DIRECTORY}
    CACHE STRING "Import paths for Qt Creator's code model"
    FORCE
)

if (BUILD_QDS_COMPONENTS)
    include(${CMAKE_CURRENT_SOURCE_DIR}/qmlcomponents)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)

if (LINK_INSIGHT)
    include(${CMAKE_CURRENT_SOURCE_DIR}/insight)
endif ()

include(GNUInstallDirs)
install(TARGETS SFMCLApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# make IDEs aware of the QML import path
set(QML_IMPORT_PATH ${PROJECT_BINARY_DIR}/qml CACHE PATH
    "Path to the custom QML components defined by the project")

