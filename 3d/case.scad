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

// pcb supports
pcb_hight = 5;
sup_hight = 4;

cube(size = [w,h,t]);

color( "DarkGreen", 1.0 )
translate([0,0,pcb_hight+t])
cube(size = [pcb_width,pcb_height,pcb_thickness]);


translate([5,0,0])
cylinder(h=20, r=10, center=true);
