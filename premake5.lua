project "GLFW"
	kind "StaticLib"
	language "C"
	staticruntime "On"

    targetdir("$(SolutionDir)" .. outputdir .. "/bin//%{prj.name}")
    objdir("$(SolutionDir)" .. outputdir .. "/bin-int/%{prj.name}")

	files
	{
		"include/GLFW/glfw3.h",
		"include/GLFW/glfw3native.h",
        "src/internal.h",
        "src/platform.h",
        "src/mappings.h",
		"src/context.c",
		"src/init.c",
		"src/input.c",
		"src/monitor.c",
		"src/egl_context.c",
		"src/osmesa_context.c",

		"src/null_platform.h",
		"src/null_init.c",
		"src/null_joystick.h",
		"src/null_joystick.c",
		"src/null_monitor.c",
		"src/null_window.c",

		"src/platform.c",
		"src/vulkan.c",
		"src/window.c",
	}

	filter "system:linux"
		pic "On"

		systemversion "latest"
		
		files
		{
            -- Linux Library
			"src/posix_time.c",
			"src/posix_time.h",
			"src/posix_thread.c",
			"src/posix_thread.h",
			"src/posix_module.c",
			"src/posix_poll.h",
			"src/posix_poll.c",
            -- X11
			"src/x11_init.c",
			"src/x11_platform.h",
			"src/x11_monitor.c",
			"src/x11_window.c",
			"src/xkb_unicode.c",
			"src/xkb_unicode.h",
			"src/glx_context.c",
            -- Wayland
            "src/wl_platform.h",
            "src/xkb_unicode.h",
            "src/wl_init.c",
            "src/wl_monitor.c",
            "src/wl_window.c",
            "src/xkb_unicode.c",
            -- X11 & Wayland
			"src/linux_joystick.c",
			"src/linux_joystick.h",
		}

		defines
		{
			"_GLFW_X11",
            "_GLFW_WAYLAND",
		}

	filter "system:windows"
		systemversion "latest"

		files
		{
            -- Win Library
            "src/win32_module.c",
			"src/win32_time.c",
			"src/win32_time.h",
			"src/win32_thread.c",
			"src/win32_thread.h",
            -- Win Build
			"src/win32_init.c",
			"src/win32_platform.h",
			"src/win32_joystick.c",
			"src/win32_joystick.h",
			"src/win32_monitor.c",
			"src/win32_window.c",
			"src/wgl_context.c",
		}

		defines 
		{ 
			"_GLFW_WIN32",
			"_CRT_SECURE_NO_WARNINGS",
		}

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

	postbuildcommands { 
		"{MKDIR}  $(SolutionDir)" .. outputdir .. "/bin/MCGame",  
		"{COPY} %{cfg.buildtarget.relpath} $(SolutionDir)" .. outputdir .. "/bin/MCGame"
	}