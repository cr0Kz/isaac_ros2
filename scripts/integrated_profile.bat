set HOME=
set ROS_DOMAIN_ID=12
set FASTRTPS_DEFAULT_PROFILES_FILE=%cd%\src\IsaacSim-ros_workspaces\humble_ws\fastdds.xml

:: Activate x64 Native Tools Command Prompt for VS 2019
call "c:\program files (x86)\microsoft visual studio\2019\community\vc\auxiliary\build\vcvars64.bat"

:: Activate the ROS 2 environment
echo Activating ROS 2 environment...
call c:\opt\ros\humble\x64\setup.bat

:: Check if the workspace install exists
if not exist install (
    echo Install directory not found. Building the workspace...
    call scripts\build_workspace.bat
    echo Activating the isaac_ros workspace...
    call install\local_setup.bat
) else (
    echo Activating the isaac_ros workspace...
    call install\local_setup.bat
)

