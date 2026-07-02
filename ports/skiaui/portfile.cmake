vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO menghuijinxi/SkiaUI
    REF 381596316b897b3e109be37563cd87cdd0dbea83
    SHA512 957eb0ee7dded49a734f69a4ec68480d94491d1de5776d2aa5f46d971df9cd7df3337b74cd0540f21680cfc2f5886eaf6720baf9ab14000aef87b0f22fe6ab49
    HEAD_REF master
)

set(SKIAUI_WIN32_DX12 OFF)
if("win32-dx12" IN_LIST FEATURES)
    set(SKIAUI_WIN32_DX12 ON)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DSKIAUI_BUILD_DEMOS=OFF
        -DSKIAUI_BUILD_TESTS=OFF
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
