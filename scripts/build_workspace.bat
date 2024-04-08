@echo off
setlocal

:: Check if Git is available
where git >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Git is not available. Please install Git or add it to your PATH.
    exit /b 1
)

:: Define paths to your submodules relative to the root of your Git repository
set "submodule_pointcloud_to_laserscan=src\pointcloud_to_laserscan"
set "submodule_vision_msgs=src\vision_msgs"
set "repo_isaacsim_ros_workspaces=src\IsaacSim-ros_workspaces"
set "repo_isaacsim_ros_workspaces_repository=https://github.com/NVIDIA-Omniverse/IsaacSim-ros_workspaces.git"

:: Check if the submodules are available
echo Checking, initializing, and updating submodules...

if not exist "%submodule_pointcloud_to_laserscan%" (
    echo Submodule at "%submodule_pointcloud_to_laserscan%" is not fetched or initialized. Fetching now...
    git submodule update --init "%submodule_pointcloud_to_laserscan%"
) else (
    echo Submodule at "%submodule_pointcloud_to_laserscan%" is already fetched and initialized.
)

if not exist "%submodule_vision_msgs%" (
    echo Submodule at "%submodule_vision_msgs%" is not fetched or initialized. Fetching now...
    git submodule update --init "%submodule_vision_msgs%"
) else (
    echo Submodule at "%submodule_vision_msgs%" is already fetched and initialized.
)

:: Check if the repository directory exists and clone if it doesn't
if not exist "%repo_isaacsim_ros_workspaces%" (
    echo The repository at "%repo_isaacsim_ros_workspaces%" does not exist. Fetching now...
    git clone "%repo_isaacsim_ros_workspaces_repository%" "%repo_isaacsim_ros_workspaces%"
    :: Remove the foxy_ws and noetic_ws directories
    rmdir /S /Q "%repo_isaacsim_ros_workspaces%\foxy_ws"
    rmdir /S /Q "%repo_isaacsim_ros_workspaces%\noetic_ws"
) else (
    echo Repository at "%repo_isaacsim_ros_workspaces%" is already fetched and initialized.
)

:: Proceed with the next steps
echo Patching the pointcloud_to_laserscan node...
call scripts\patch_pointcloud_to_laserscan_node.bat

echo Building isaac_ros and IsaacSim-ros_workspaces...
colcon build --packages-skip vision_msgs_rviz_plugins --merge-install

endlocal
