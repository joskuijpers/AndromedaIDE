JSphere
=======

Sphere RPG Engine and IDE for Mac OSX. Not created by the developers and maintainers of the original Sphere!

This repository also contains my ObjC wrapper for V8. It is unsafe, unstable, untested. Do not use it. (I don't).

The whole project:

* Sphere.app
 * The Sphere IDE for Mac
* SphereKit.framework
 * A kit used by Sphere.app and IDE plugins
* SphereToolsKit.framework
 * This is a provider for external tools in a wrapper package. It will be able to use multiple lints, optimizers, etc to do optimizing, syntax checking, minimizing, etc. 
* SphereRuntimeKit.framework
 * Commons used by Sphere and SphereRuntime
* SphereRuntime.app
 * The actual runtime
* L8Framework.framework
 * The ObjC V8 wrapper
* L8Console
 * A remote debugger for L8


Why is this repository private?
===

Because I am lazy, mostly. Xcode automatically adds an All Rights Reserved in my files and I need to change that to a proper open license. But even more, the code is emberassingly messy, and the L8Framework might not be 1000% legal due to the vast similarities with WebKit JSC ObjC API... I might just need to move it out of the project.

License
===
The current license is Closed Source, because I am lazy as stated above. I am planning to use a BSD license, because it rocks.
