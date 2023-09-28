=== sie2mat ===
Contributors: Joachim Stallmann, Theunis Botha
More Info link: https://www.facebook.com/TuksVDG
Tags: sie, mat, HBM, eDaq, video 
Tested on: 01:31 PM 2015/06/09
Stable version: 2.1


The program sie2mat.exe( SIE 2(to) MATlab ) reads binary SIE files and saves the data as a mat files.

== Description ==

The program sie2mat.mex reads binary SIE files and loads the data into the MATLAB workspace.


== Installation ==


1. How do I compile sie2mat:
	- Run "setup -mex" to ensure a supported and compatible compiler has been setup.
		( A list of suported compilers: http://www.mathworks.com/support/compilers/R2015b/index.html)
	- Download the latest sie2mat.cpp code (located in the source_code folder). 
	- Download the latest libsie and libapr libraries( located in the lib folder - all files in the x86/x64 subfolder)
	- Make sure that the source code and the necessary libaries are in the same folder.
	- Run compile_sie2mat (located in the Matlab_code folder)


== Frequently Asked Questions ==



1. Error compiling sie2mat.cpp
	- This could be due to various problems. Please read the error message carefully.
	- A error massage that seems to be happening quite often is :
		c:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\INCLUDE\intrin.h(26) : fatal error C1083: Cannot open include file: 'ammintrin.h': No such file or directory 
	-This is a Microsoft Bug see  http://www.mathworks.com/matlabcentral/answers/90383-fix-problem-when-mex-cpp-file
	-Download the ammintrin.h header file (located in the ammintrin folder) and place it into:
		 "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\INCLUDE\"

2. Error running sie2mat.mex
	- This could be due to various problems. Please read the error message carefully.
	- A error massage that seems to be happening quite often is :
		Invalid MEX-file sie2mat:
		The specified module could not be found.
	- This module cannot find its dependent libraries. See http://www.mathworks.com/matlabcentral/answers/92362-how-do-i-determine-which-libraries-my-mex-file-or-stand-alone-application-requires
	- A quikfix might be to download and install the Microsoft Visual C++ 2012 Redistributable Package. The libsie and libapr-1 libraries were built with Visual Studio 2012.

== Change log ==

= 2.1.0 =
*sie2mat 2.1 runs more stable than v2.0.
*improved stability and speed.
* Released: 2015/12/17

= 2.0.0 =
*sie2mat 2.0 can now be compiled as a mex function.
*cannot be compiled as an exe.
* Released: 2015/06/09

= 1.3.0 =
* Combined sie2mat_sa.exe and sie2mat_ws.exe to single sie2mat.exe
* Released: 2014/03/11

= 1.2.0 =
* Changed output to single precision.
* Released: 2013/08/26

= 1.1.0 =
* Support for multiple test runs added.
* Released: 2013/08/26

= 1.0.0 =
* First stable version.
* Released: 2013/07/26
