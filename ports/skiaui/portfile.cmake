vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO menghuijinxi/SkiaUI
    REF 7d141d76442582bb2b401b407d3bcdebe459011d
    SHA512 c368f3799f91fcfbcd16000efdf412e56c73e41034c049189eb44cc4892dcd08df0e9ad6c3adc3e521b1a12c3b694b0aa5badb5e462d02ba47080115aa8f6f18
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
