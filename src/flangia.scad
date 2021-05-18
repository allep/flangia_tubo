// Flangia per tubo
// Author: Alessandro Paganelli (alessandro.paganelli@gmail.com)

// Measures: in mm

// Constants
$fn = 50;
CYLINDER_H = 30;

// Radius + 1% tolerance
CYLINDER_INNER_R = 11.1;
CYLINDER_THICKNESS = 1.5;
FLANGE_H = 2;
FLANGE_THICKNESS = 10;

// Screws: M4 + 8% tolerance
SCREW_RADIUS = 2.16;
SCREW_HEAD_RADIUS = 2.9;
SCREW_H = FLANGE_H;

// Actual script

cylinder_external_r = CYLINDER_INNER_R + CYLINDER_THICKNESS;
screw_distance = cylinder_external_r + FLANGE_THICKNESS / 2;

// Modules
module screw_hole(screw_radius, head_radius, depth)
{
    union()
    {
        // hole
        cylinder(h = depth, r = screw_radius);
        // screw head
        translate([0, 0, depth / 2])
        cylinder(h = depth / 2, r1 = screw_radius, r2 = head_radius);
    }
}

difference()
{
    union()
    {
        cylinder(h = CYLINDER_H, r = cylinder_external_r);
        difference()
        {
            // Flange with screw holes
            cylinder(h = FLANGE_H, r = cylinder_external_r + FLANGE_THICKNESS);
            
            translate([screw_distance, 0, 0])
            screw_hole(SCREW_RADIUS, SCREW_HEAD_RADIUS, FLANGE_H);
            
            translate([-screw_distance, 0, 0])
            screw_hole(SCREW_RADIUS, SCREW_HEAD_RADIUS, FLANGE_H);
            
            translate([0, screw_distance, 0])
            screw_hole(SCREW_RADIUS, SCREW_HEAD_RADIUS, FLANGE_H);
            
            translate([0, -screw_distance, 0])
            screw_hole(SCREW_RADIUS, SCREW_HEAD_RADIUS, FLANGE_H);
        }
    }
    cylinder(h = CYLINDER_H, r = CYLINDER_INNER_R);
}