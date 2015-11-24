module lens() {
	intersection() {
		linear_extrude(height=15)
			import("LeftLensFrontView.dxf",$fn=250);
		translate([0,20,5])
			rotate( [90,0,0] )
				linear_extrude(height=50)
					import("LeftLensTopView.dxf",$fn=250);
	}
}

module lens_case() {
	difference() {
		translate([3,0.75,1])
			linear_extrude(height=10)
				scale([1.1,1.15,1])
					import("LeftLensFrontView.dxf",$fn=250);
		linear_extrude(height=15)
			scale([0.97,0.95,0.97])
				import("LeftLensFrontView.dxf",$fn=250);	
	}
}

module lens_assembly() {
	difference() {
		union() {
			lens_case();
			translate([-59,-3.5,1])
				cube([9,7,10]);
		}
		union() {
			translate([1.5,0.2,-0.5])
				scale([1.025,1.025,1.05])
					lens();
			translate([-59.5,-0.5,-0.1])
				cube([13,1,15]);
			translate([-55.5,10,6])
				rotate([90,0,0])
					cylinder(r=1.5,h=25,$fn=24);
		}
	}
}

// Nose-piece for bridge
module nosepiece() {
	difference() {
		union() {
			translate([10,0,4])
				rotate([0,-10,10])
				rotate([0,90,0])
					cylinder(r=10,h=3,$fn=24);
			translate([-10,0,4])
				rotate([0,10,-10])
				rotate([0,-90,0])
					cylinder(r=10,h=3,$fn=24);
		}
		cube([100,100,20],center=true);
	}
}

module bridge() {
	difference() {
		union() {
			translate([0,4,6])
				cube([22,4,10],center=true);
			translate([0,6,6])
				cube([26.5,2,10],center=true);
		}

		union() {
			translate([1,-10,15])
				rotate([-60,0,0])
					cylinder(r=15,h=20,$fn=24);

			translate([1,15,22])
				rotate([90,0,0])
					cylinder(r=15,h=20,$fn=24);
		}
	}
}

difference() {
	// Raw Frames
	union() {
		// Left Lens Assembly
		translate([-12.5,0,0])
			lens_assembly();

		// Right Lens Assembly
		mirror([1,0,0])
			translate([-12.5,0,0])
				lens_assembly();

		// Bridge
		bridge();
	}

	// Add curve to face-facing portion of frames
	union() {
		translate([35,20,158.5])
			rotate([90,0,0])
				cylinder(r=150,h=100,$fn=120);
	
		translate([-35,20,158.5])
			rotate([90,0,0])
				cylinder(r=150,h=100,$fn=120);
	}
}

nosepiece();
