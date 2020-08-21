workspace "RenderEngine"
  architecture "x64"

  configurations {
    "Debug",
    "Release",
    "Dist"
  }

outdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

indirs = {}
indirs["GLFW"] = "RenderEngine/vendor/GLFW/include/"

include "RenderEngine/vendor/premake5.glfw.lua"

project "RenderEngine"
  location "RenderEngine"
  kind "ConsoleApp"
  language "C++"

  targetdir("bin/" ..outdir.. "/%{prj.name}")
  objdir("bin-int/" ..outdir.. "/%{prj.name}")

  files {
    "%{prj.name}/src/**.h",
    "%{prj.name}/src/**.cpp"
  }

  includedirs {
		"%{indirs.GLFW}"
  }

  links { 
    "GLFW",
  }

  filter "system:macosx"
    systemversion "latest"
    staticruntime "On"

    defines {
      "GL_SILENCE_DEPRECATION"
    }

    links {
      "Cocoa.framework",
      "IOKit.framework",
      "CoreVideo.framework",
      "OpenGL.framework"
    }

  filter "configurations:Debug"
    symbols "On"

  filter "configurations:Release"
    optimize "On"

  filter "configurations:Dist"
    optimize "On"