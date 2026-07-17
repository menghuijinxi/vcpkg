vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL "http://10.1.1.58:8418/SunXuJing/SkiaUI.git"
    REF 16cca3cd7af4eb8553c2bf9151144e98d906e90d
    HEAD_REF master
)

set(SKIAUI_DEMO OFF)
if("demo" IN_LIST FEATURES)
    set(SKIAUI_DEMO ON)
endif()

set(SKIAUI_WIN32 OFF)
if("win32" IN_LIST FEATURES OR "win32-dx12" IN_LIST FEATURES OR SKIAUI_DEMO)
    set(SKIAUI_WIN32 ON)
endif()

set(SKIAUI_WIN32_DX12 OFF)
if("win32-dx12" IN_LIST FEATURES OR SKIAUI_DEMO)
    set(SKIAUI_WIN32_DX12 ON)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DSKIAUI_BUILD_DEMOS=OFF
        -DSKIAUI_BUILD_TESTS=OFF
        -DSKIAUI_BUILD_SKIA_UI_DESK=${SKIAUI_DEMO}
        -DSKIAUI_INSTALL_SKIA_UI_DESK=${SKIAUI_DEMO}
        -DSKIAUI_BUILD_WIN32=${SKIAUI_WIN32}
        -DSKIAUI_INSTALL_WIN32=${SKIAUI_WIN32}
        -DSKIAUI_BUILD_WIN32_DX12=${SKIAUI_WIN32_DX12}
        -DSKIAUI_INSTALL_WIN32_DX12=${SKIAUI_WIN32_DX12}
        -DSKIATEST_USE_SKIA_D3D=ON
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright"
    "SkiaUI currently does not declare a license.\n"
)
