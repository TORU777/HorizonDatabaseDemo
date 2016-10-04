// Fill out your copyright notice in the Description page of Project Settings.

using UnrealBuildTool;

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



        PrivateDependencyModuleNames.AddRange(new string[] { "soci_core", "soci_sqlite3" });
        // PrivateDependencyModuleNames.AddRange(new string[] { "sqlite3Static" });
        System.Diagnostics.Debug.WriteLine("===== ModuleLibSqlite3PublicIncludePath:" + ModuleLibSqlite3PublicIncludePath);
        PublicIncludePaths.AddRange(
          new string[] {
              "Public",
               ModuleLibSociPublicIncludePath,
               ModuleLibSqlite3PublicIncludePath,

              // ... add public include paths required here ...
          }
          );


        PrivateIncludePaths.AddRange(
            new string[] {
				// ... add other private include paths required here ...
			}
            );
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
