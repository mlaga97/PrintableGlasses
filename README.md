# Printable Glasses
3d-printable glasses frames that are parametrically generated around arbitrary lens shapes.

# Software Tools Needed
1. [OpenSCAD](http://www.openscad.org/)
2. A 2D CAD Package (e.g. [LibreCAD](https://github.com/LibreCAD/LibreCAD))

# Hardware Needed
1. A 3D Printer
2. 2x M3x20mm Socket Head Cap Screws
3. 2x M3 Nut

# Vague Instructions
1. Replace `Frames/LeftLensFrontView.dxf` and `Frames/LeftLensTopView.dxf` with scaled outlines of lens shape in units of mm.
2. Build Frames/Frame.scad to generate a Frame.stl file and print. If lens does not fit, use of a scaling factor may be appropriate.
3. Select the appropriate GlassesArm from `Arms/GlassesArm_[LENGTH]mm.stl` and print 2 copies.
