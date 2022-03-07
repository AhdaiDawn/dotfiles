cpp单文件

    - 编译 `:!clang++ % -o ./build/%:t:r`
    - 运行 `:!./build/%:t:r`

cmake项目

    - 配置 `cmake -B./build`
    - 编译 `cmake --build ./build --target all`
    - 安装 `cmake --build ./build --config Release --target install`或者 `cmake --build ./build --config Debug --target install`

CMakeLists.txt示例:
``` cmake
cmake_minimum_required(VERSION 3.22)

# Set the project name
project (folly-demo)

find_package(gflags REQUIRED)
find_package(folly REQUIRED)

# Add an executable
add_executable(folly-demo main.cpp)
target_link_libraries(folly-demo Folly::folly)
```
