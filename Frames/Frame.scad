lensWidth = 54;
lensHeight = 36;

parameter_a = 1.5;
parameter_b = 1.5;
parameter_c = -11.95;
parameter_d = 0.22;

parameter_e = 9;
parameter_f = 47;
parameter_g = 17;
parameter_h = 1.3;

parameter_i = 100;

// Right lens
module lens() {
	intersection() {
		linear_extrude(height=15)
			import("RightLensFrontView.dxf",$fn=250);
		translate([0,20,0])
			rotate( [90,0,0] )
				linear_extrude(height=50)
					import("RightLensTopView.dxf",$fn=250);
	}
}

module lens_case() {
  translate([lensWidth/2, (lensHeight+parameter_a*2)/lensHeight * -(parameter_c + lensHeight/2), 0]) // TODO: Y is probably wrong
    difference() {
      union() {
        linear_extrude(height = 20)
          scale([(lensWidth+parameter_a*2)/lensWidth,(lensHeight+parameter_a*2)/lensHeight])
            translate([-lensWidth/2, parameter_c + lensHeight/2, 0])
              import("RightLensFrontView.dxf",$fn=250);
      }
      translate([0, 0, -1])
        linear_extrude(height=100)
          scale([(lensWidth-parameter_b*2)/lensWidth,(lensHeight-parameter_b*2)/lensHeight])
            translate([-lensWidth/2, parameter_c + lensHeight/2, 0])
              import("RightLensFrontView.dxf",$fn=250);	
    }
}

module lens_assembly() {
  intersection() {
    difference() {
      union() {
        lens_case();
        translate([lensWidth, -6.5/2, 0])
          cube([parameter_a + parameter_d + 6.5, 6.5, 10]);
      }

      translate([0, 0, 1.5]) // TODO: Parameterize
        scale([1, 1, 1.2]) // TODO: Parameterize
          lens();

      translate([lensWidth/2, -1/2, -1])
        cube([lensWidth, 1, 10 + 2]);

      translate([lensWidth + parameter_a + parameter_d + 6.5/2, 0, 5])
        rotate([90, 0, 0])
          cylinder(d = 3, h = 25, $fn = 24, center = true);

      intersection() {
        translate([(lensWidth - parameter_e + parameter_a + parameter_d)/2 + parameter_e, 20, 10 + sqrt(pow(parameter_i, 2) - pow((lensWidth - parameter_e + parameter_a + parameter_d)/2, 2))]) // TODO: Parameterize
          rotate([90, 0, 0])
            cylinder(r = parameter_i, h = 100, $fn=120);

        translate([parameter_e, -50, 0])
          cube([lensWidth - parameter_e + parameter_a + parameter_d, 100, 100]);
      }
    }

    // TODO: Parameterize
    union() {
      translate([-10, -10 + 2, -30/2 + 10 + 5])
        rotate([0, 90, 0])
          cylinder(d = 30, h = 20);
      translate([-10, -50, 0])
        cube([100, 100, 10]);
    }

  }
}

module bridge() {
	difference() {
		union() {
			translate([0,4,9/2])
				cube([parameter_g - parameter_a/2, 4, 9],center=true);
			translate([0,6,9/2])
				cube([parameter_g - parameter_a/2 + parameter_h, 2, 9],center=true);
		}

		union() {
			translate([0,-10,15-2])
				rotate([-60,0,0])
					cylinder(r=15,h=20,$fn=24);

			translate([0,15,22-2])
				rotate([90,0,0])
					cylinder(r=15,h=20,$fn=24);
		}
	}
}

difference() {
	// Raw Frames
	union() {
    for (m = [0, 1])
      mirror([m, 0, 0])
        translate([parameter_g/2,0,0])
          lens_assembly();

		// Bridge
    translate([0, -2, 0])
      bridge();
	}
}
