/******************************************************
* Boost Software License - Version 1.0 - 2016/10/06
*
* Copyright (c) 2016 dorgon chang
* http://dorgon.horizon-studio.net/
*
* Permission is hereby granted, free of charge, to any person or organization
* obtaining a copy of the software and accompanying documentation covered by
* this license (the "Software") to use, reproduce, display, distribute,
* execute, and transmit the Software, and to prepare derivative works of the
* Software, and to permit third-parties to whom the Software is furnished to
* do so, all subject to the following:
*
* The copyright notices in the Software and this entire statement, including
* the above license grant, this restriction and the following disclaimer,
* must be included in all copies of the Software, in whole or in part, and
* all derivative works of the Software, unless such copies or derivative
* works are solely in the form of machine-executable object code generated by
* a source language processor.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
* SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
* FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
* DEALINGS IN THE SOFTWARE.
**********************************************************/

using UnrealBuildTool;
using System;
using System.IO;

public class HorizonDatabaseDemo : ModuleRules
{
	public HorizonDatabaseDemo(TargetInfo Target)
	{
		PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore" });

		PrivateDependencyModuleNames.AddRange(new string[] {  });

        // Uncomment if you are using Slate UI
        // PrivateDependencyModuleNames.AddRange(new string[] { "Slate", "SlateCore" });

        // Uncomment if you are using online features
        // PrivateDependencyModuleNames.Add("OnlineSubsystem");

        // To include OnlineSubsystemSteam, add it to the plugins section in your uproject file with the Enabled attribute set to true



       
        // PrivateDependencyModuleNames.AddRange(new string[] { "sqlite3Static" });
        System.Diagnostics.Debug.WriteLine("===== ModuleLibSqlite3PublicIncludePath:" + ModuleLibSqlite3PublicIncludePath);
        PublicIncludePaths.AddRange(
          new string[] {
              "Public",
              ModuleHorizonDatabasePublicIncludePath,
              ModuleLibSociPublicIncludePath,
              ModuleLibSqlite3PublicIncludePath,

              // ... add public include paths required here ...
          }
          );


        PrivateIncludePaths.AddRange(
            new string[] {
                "Private"
				// ... add other private include paths required here ...
			}
            );

        //bUseRTTI = true; // turn on RTTI

    }

    private string ModuleRootPath
    {
        get
        {
            string ModuleCSFilename = UnrealBuildTool.RulesCompiler.GetFileNameFromType(GetType());
            string ModuleCSFileDirectory = Path.GetDirectoryName(ModuleCSFilename);
            return Path.Combine(ModuleCSFileDirectory);
        }
    }



    private string ModuleHorizonDatabasePublicIncludePath
    {
        get
        {
            return Path.GetFullPath(Path.Combine(ModuleRootPath, "..", "..", "Plugins", "HorizonDatabasePlugin", "Source", "Runtime", "HorizonDatabase", "Public"));
        }
    }

    private string ModuleLibSociPublicIncludePath
    {
        get
        {
            return Path.GetFullPath(Path.Combine(ModuleRootPath, "..", "..", "Plugins", "HorizonDatabasePlugin", "Source", "ThirdParty", "LibSoci", "soci", "include"));
        }
    }



    private string ModuleLibSqlite3PublicIncludePath
    {
        get
        {
            return Path.GetFullPath(Path.Combine(ModuleRootPath, "..", "..", "Plugins", "HorizonDatabasePlugin", "Source", "ThirdParty", "LibSqlite3", "sqlite3", "src"));
        }
    }
}
