/*
    DM50 - Javier Báscones Velázquez - 2024
*/

$fn=30;
// PCB -----------------------
pcb_height = 138;
pcb_thickness = 2;
pcb_width = 71;
// CASE -----------------------
// thickness
t = 2;
// width
w = 77; 
// height
h = 144;
// depth
d = 12;
// height bottom
bottom_height = 10;
bottom_sup_height = 3;
bottom_sup_ymin = t;
bottom_sup_ymax = 85;
bottom_sup_xmin = t;
bottom_sup_xmax = w-t;

bottom_ysupports = 5;
bottom_xsupports = 5;

screw_h = 95;
screw_r = 6;


// pcb supports
pcb_hight = 5;
sup_hight = 4;
keypad_radio_sup = 1;

// base
cube(size = [w,h,t]);
// walls
cube(size = [t, h, bottom_height]);
translate([w-t, 0, 0])
cube(size = [t, h, bottom_height]);
cube(size = [w, t, bottom_height]);
translate([0, h-t, 0])
cube(size = [w, t, bottom_height]);

// support
for ( i = [0 : bottom_ysupports-1] ){
    translate([0, bottom_sup_ymin+i*(bottom_sup_ymax-bottom_sup_ymin-t)/(bottom_ysupports-1), t])
    cube(size = [w, t, bottom_sup_height]);
}

for ( i = [0 : bottom_xsupports-1] ){
    translate([bottom_sup_xmin+i*(bottom_sup_xmax-bottom_sup_xmin-t)/(bottom_xsupports-1), 0, t])
    cube(size = [t, bottom_sup_ymax, bottom_sup_height]);
}

// screws
translate([6, screw_h, 0])
cylinder(h=bottom_sup_height+t, r=screw_r, center=false);
translate([w-6, screw_h, 0])
cylinder(h=bottom_sup_height+t, r=screw_r, center=false);

//color( "DarkGreen", 1.0 )
//translate([0,0,pcb_hight+t])
//cube(size = [pcb_width,pcb_height,pcb_thickness]);

//cylinder(h=20, r=keypad_radio_sup, center=true);
