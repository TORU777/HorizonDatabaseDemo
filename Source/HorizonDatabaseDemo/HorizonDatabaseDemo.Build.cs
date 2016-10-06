// Created by dorgon, All Rights Reserved.
// email: dorgonman@hotmail.com
// blog: dorgon.horizon-studio.net

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
