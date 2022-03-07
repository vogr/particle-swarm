cmake_minimum_required(VERSION 3.17)
project(opus_with_libs VERSION 1.0)

set(CMAKE_PREFIX_PATH, ${CONDA_PREFIX})

find_package(Eigen3 3.4 REQUIRED NO_MODULE)
find_package(Ceres 2.0 REQUIRED)

add_executable(opus src/main.cpp)


target_link_libraries(opus PRIVATE Eigen3::Eigen)
target_link_libraries(opus PRIVATE Ceres::ceres)

target_compile_options(opus
      PUBLIC
      $<$<CONFIG:Debug>:-O0 -ggdb3 -gsplit-dwarf>
      $<$<CONFIG:Release>:-O2 -march=native -flto -fno-fat-lto-objects> # release: 03 is implied, add back 02
      $<$<CONFIG:RelWithDebInfo>:-O2 -march=native -ggdb3 -flto -fno-fat-lto-objects> # relwithdebinfo: 02 is implied
  )
