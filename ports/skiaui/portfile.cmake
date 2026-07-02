vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO menghuijinxi/SkiaUI
    REF 120182b423982dac941cad579ee047f70c3f9c6f
    SHA512 895e37d91af9268269775ffdb274902f6a697634f8ba7c8b99c73fc5a6e5fda83e78790f23ecba5ed5aac8f2362ebc9eff68545269967d51b43a53d7258588dd
    HEAD_REF master
)

set(SKIAUI_WIN32 OFF)
if("win32" IN_LIST FEATURES OR "win32-dx12" IN_LIST FEATURES)
    set(SKIAUI_WIN32 ON)
endif()

set(SKIAUI_WIN32_DX12 OFF)
if("win32-dx12" IN_LIST FEATURES)
    set(SKIAUI_WIN32_DX12 ON)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DSKIAUI_BUILD_DEMOS=OFF
        -DSKIAUI_BUILD_TESTS=OFF
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
