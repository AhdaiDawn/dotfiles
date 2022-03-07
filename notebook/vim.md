cpp单文件
    - 编译 `:!clang++ % -o ./build/%:t:r`
    - 运行 `:!./build/%:t:r`

cmake项目
    - 配置 `cmake -B./build`
    - 编译 `cmake --build ./build --target all`
