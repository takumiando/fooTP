module rounded_cylinder(height, r) {
    hull() {
        translate([0, 0, r])
            sphere(r);
        translate([0, 0, height-r])
            sphere(r);
    }
}

module rib(r, width, height) {
    hull() {
        translate([r, r, 0])
            rounded_cylinder(height, r);
        translate([width-r, width-r, 0])
            rounded_cylinder(height, r);
    }

     hull() {
        translate([r, width-r, 0])
            rounded_cylinder(height, r);
        translate([width-r, r, 0])
            rounded_cylinder(height, r);
    }
}

module base(r, width, height) {
    hull() {
        translate([r, r, 0])
            rounded_cylinder(height, r);
        translate([width-r, r, 0])
            rounded_cylinder(height, r);
    }

    hull() {
        translate([r, width-r, 0])
            rounded_cylinder(height, r);
        translate([width-r, width-r, 0])
            rounded_cylinder(height, r);
    }

    hull() {
        translate([r, r, 0])
            rounded_cylinder(height, r);
        translate([r, width-r, 0])
            rounded_cylinder(height, r);
    }

    hull() {
        translate([width-r, r, 0])
            rounded_cylinder(height, r);
        translate([width-r, width-r, 0])
            rounded_cylinder(height, r);
    }

    rib(r, width, height);
}

module footp(grid_hole_side, grid_hole_gap) {
    $fn=120;
    grid_pitch = grid_hole_side + grid_hole_gap;
    width = grid_hole_side * 3 + grid_hole_gap * 2;
    corner_rib_offset = grid_pitch * 2;

    /* Extend the 45-degree caster mount to meet the outer rib. */
    caster_mount_extent = max(14, 14 + (width - 50) / sqrt(2));

    difference() {
        union() {
            /* Base */
            base(2, width, 8);

            rib(2, grid_hole_side, 18);
            translate([corner_rib_offset, 0, 0])
                rib(2, grid_hole_side, 18);
            translate([0, corner_rib_offset, 0])
                rib(2, grid_hole_side, 18);
            translate([corner_rib_offset, corner_rib_offset, 0])
                rib(2, grid_hole_side, 18);
            translate([grid_pitch, grid_pitch, 0])
                rib(2, grid_hole_side, 18);

            translate([width/2, width/2, 0]) {
                rotate([0, 0, 45]) {
                    hull() {
                        translate([-23/2, -caster_mount_extent, 0])
                            cylinder(8, 6, 6);
                        translate([-23/2, caster_mount_extent, 0])
                            cylinder(8, 6, 6);
                    }
                    hull() {
                        translate([23/2, -caster_mount_extent, 0])
                            cylinder(8, 6, 6);
                        translate([23/2, caster_mount_extent, 0])
                            cylinder(8, 6, 6);
                    }
                }
            }
        }

        translate([width/2, width/2, 0]) {
            rotate([0, 0, 45]) {
                translate([-23/2, -28/2, 0]) {
                    cylinder(8, 4.5/2, 4.5/2);
                    translate([0, 0, 8-3.5])
                        rotate([0, 0, 30])
                            cylinder(8, 8.2/2, 8.2/2, $fn=6);
                }
                translate([-23/2, 28/2, 0]) {
                    cylinder(8, 4.5/2, 4.5/2);
                    translate([0, 0, 8-3.5])
                        rotate([0, 0, 30])
                            cylinder(8, 8.2/2, 8.2/2, $fn=6);
                }
                translate([23/2, -28/2, 0]) {
                    cylinder(8, 4.5/2, 4.5/2);
                    translate([0, 0, 8-3.5])
                        rotate([0, 0, 30])
                            cylinder(8, 8.2/2, 8.2/2, $fn=6);
                }
                translate([23/2, 28/2, 0]) {
                    cylinder(8, 4.5/2, 4.5/2);
                    translate([0, 0, 8-3.5])
                        rotate([0, 0, 30])
                            cylinder(8, 8.2/2, 8.2/2, $fn=6);
                }
            }
        }
    }
}
