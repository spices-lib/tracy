function table.contains(t, value)
    for _, v in ipairs(t) do
        if v == value then return true end
    end
    return false
end

GetTracyExternalIncludes = function()

    local list = {}

	local graphics = platform.GetGraphicsFeatures()

    if table.contains(graphics, "NP_GRAPHICS_OPENGL") then
        table.insert(list, vendor.Glad.includes)
    end

	if table.contains(graphics, "NP_GRAPHICS_VULKAN") then
        table.insert(list, vendor.Vulkan.includes)
    end

    return list

end

solution.DefineCStaticLibrary("tracy", function()

	files
	{
		"public/TracyClient.cpp",
	}

	includedirs
	{
		vendor.tracy.includes
	}

	externalincludedirs
	{
		GetTracyExternalIncludes()
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

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++20"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

end)