difference() {
	linear_extrude(7)
		import("GlassesArm_115mm.dxf");
	translate([5,17,3.5])
		rotate([90,0,0])
			cylinder(r=1.5,h=25,$fn=24);
}