----------------------------------------------  
<h2 align="center">				
			HorizonDatabasePlugin<br>
					0.2.0(beta)   <br>
			http://dorgon.horizon-studio.net  <br>
				dorgonman@hotmail.com  <br>
</h2>
----------------------------------------------  

The goal of thie plugin is to provide a SOCI wrapper for UE4 and ORM ability.  

What is SOCI? It is a C++ Database Access Library, you can check detail [here](https://github.com/SOCI/soci).    

You can find document here: [doc/doxygen/html/index.html](http://horizon-studio.net/ue4/horizon_database_plugin/doc/doxygen/html/index.html)  

-----------------------  
System Requirements
-----------------------  

Tested UnrealEngine version: 4.13

-----------------------
Installation Guide
-----------------------  

put HorizonDatabasePlugin into YOUR_PROJECT/Plugins folder, 
and then add module to your project 
YOUR_PROJECT.Build.cs:
PublicDependencyModuleNames.AddRange(new string[] { "HorizonDatabase"});



-----------------------
Technical Details
-----------------------  

List of Modules: HorizonDatabaseEditor(Editor), HorizonDatabase (Runtime)  

-------------------------------------------------------------------
Current Database backend implementation status
-------------------------------------------------------------------
__DB2__: not implemented  

__Firebird__: not implemented  

__MySQL__: not implemented  

__ODBC__: not implemented  

__Oracle__: not implemented  

__PostgreSQL__: not implemented  

__Sqlite3__: implemented  

-------------------------------------------------------------------
Tested Platform
-------------------------------------------------------------------
__Tested Engine veriosn__: 4.13.  

__Windows__: tested.  

__MACOSX__: Failed. need modify engine(Engine/Source/Programs/UnrealBuildTool/Mac/MacToolChain.cs) to enable rtti. 

__Android__: tested, need cherry pick this [commit][AndroidAndiOSBuildFixLink] and rebuild engine source code.  

__iOS__: not tested, need cherry pick this [commit][AndroidAndiOSBuildFixLink] and rebuild engine source code.  

__Linux__: not tested.  
  
[AndroidAndiOSBuildFixLink]: https://github.com/dorgonman/UnrealEngine/commit/ba8b2df57b067aa461f4d3fc4d0703d2ff1041aa  "Enable Rtti and Exception"  



-----------------------
Contact and Support
-----------------------  

email: dorgonman@hotmail.com


-----------------------
 Version History
-----------------------  

* 0.2.0
 - Refactor: Implement and adjust function for blueprint
 - BugFix: Fix UTF8 type_conversion from db to FString

* 0.1.0
 - NEW: First Version including core features.
