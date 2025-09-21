project "tracy"
	kind "StaticLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"public/TracyClient.cpp",
	}

	includedirs
	{
		"%{IncludeDir.tracy}",
	}

	defines
	{
		"TRACY_ENABLE",
		"TRACY_ON_DEMAND",
		"TRACY_FIBERS",
		"TRACY_IMPORT",
	}

	filter "system:windows"
		systemversion "latest"
		cppdialect "C++20"
		staticruntime "On"

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++20"
		staticruntime "On"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
