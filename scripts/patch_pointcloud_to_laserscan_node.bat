@echo off
set "file=src\pointcloud_to_laserscan\src\pointcloud_to_laserscan_node.cpp"
set "tempfile=pointcloud_to_laserscan_node.patch"

:: Check if the tempfile already exists and delete it to avoid appending to old data
if exist "%tempfile%" del "%tempfile%"

:: Create a new tempfile and write the lines you want to prepend
(
echo #ifndef M_PI
echo     #define M_PI 3.14159265358979323846
echo #endif
) > "%tempfile%"

:: Append the original file's content to the tempfile
type "%file%" >> "%tempfile%"

:: Replace the original file with the tempfile
move /y "%tempfile%" "%file%"
