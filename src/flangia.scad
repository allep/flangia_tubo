// Flangia per tubo
// Author: Alessandro Paganelli (alessandro.paganelli@gmail.com)

// Measures: in mm

// Constants
$fn = 50;
CYLINDER_H = 10;

// Radius + 2% tolerance
CYLINDER_INNER_R = 11.22;
CYLINDER_THICKNESS = 1.5;
FLANGE_H = 2;
FLANGE_THICKNESS = 10;

// Screws: M4 + 8% tolerance
SCREW_RADIUS = 2.16;
SCREW_H = FLANGE_H;

// Actual script

cylinder_external_r = CYLINDER_INNER_R + CYLINDER_THICKNESS;
screw_distance = cylinder_external_r + FLANGE_THICKNESS / 2;

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
            cylinder(h = FLANGE_H, r = SCREW_RADIUS);
            
            translate([-screw_distance, 0, 0])
            cylinder(h = FLANGE_H, r = SCREW_RADIUS);
            
            translate([0, screw_distance, 0])
            cylinder(h = FLANGE_H, r = SCREW_RADIUS);
            
            translate([0, -screw_distance, 0])
            cylinder(h = FLANGE_H, r = SCREW_RADIUS);
        }
    }
    cylinder(h = CYLINDER_H, r = CYLINDER_INNER_R);
}